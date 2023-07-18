{ config, pkgs, lib, inputs, ... }: {
    imports = [ ./graphical.nix ]
    config = lib.mkMerge ([
        { #--{Locale Configuration}------------#
            time.timeZone = "America/Detroit";
            i18n.defaultLocale = "en_US.UTF-8";
            console = {
                keyMap = "us";
            };
            fonts = {
                fonts = with pkgs; [
                    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
                    openmoji-color
                ];
                fontconfig = {
                    hinting.autohint = true;
                    defaultFonts = {
                          emoji = [ "OpenMoji Color" ];
                    };
                };
            };
        }
        { #--{Package Management}--------------#
            nixpkgs.config.allowUnfree = true;
            documentation = {
                enable = true;
                doc.enable = false;
                man.enable = true;
                dev.enable = false;
            };
            nix = {
                extraOptions = ''
                    warn-dirty = false
                    keep-outputs = true
                    keep-derivations = true
                    min-free = ${toString (100 * 1024 * 1024)}
                    max-free = ${toString (1024 * 1024 * 1024)}
                    experimental-features = nix-command flakes recursive-nix
                '';
                gc = {
                    options = "--delete-older-than 3d";
                    automatic = true;
                    dates = "daily";
                };
                optimise = {
                    automatic = true;
                    dates = [ "weekly" ];
                };
                settings = {
                    log-lines = 20;
                    sandbox = true;
                    max-jobs = "auto";
                    auto-optimise-store = true;
                    flake-registry = "/etc/nix/registry.json";
                    # allow sudo users to mark the following values as trusted
                    allowed-users = ["@wheel"];
                    # only allow sudo users to manage the nix store
                    trusted-users = ["@wheel"];
                    # continue building derivations if one fails
                    keep-going = true;
                    extra-experimental-features = [
                        "flakes" "nix-command" "recursive-nix" "ca-derivations"
                    ];
                    # use binary caches
                    builders-use-substitutes = true;
                    # List of caches to use
                    substituters = [
                        #"https://cache.nixos.org"
                        "https://nixpkgs-unfree.cachix.org"
                        "https://nix-community.cachix.org"
                        "https://nixpkgs-wayland.cachix.org"
                        "https://hyprland.cachix.org"
                    ];
                    trusted-public-keys = [
                        #"cache.nixos.org-1:"
                        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
                        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                    ];
                };
                # Add system inputs to legacy channels to keep commands consistent
                nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
                # Pin registry to avoid evaluating a new nixpkgs version every time
                registry = lib.mapAttrs (_: v: {flake = v;}) inputs;
                # Run builds with low priority to preserve system responsiveness
                daemonCPUSchedPolicy = "idle";
                daemonIOSchedClass = "idle";
            };
            environment.defaultPackages = [];
        }
        { #--{Kernel Configuration}------------#
            # Disable SysRq keychord
            boot.kernel.sysctl = { "kernel.sysrq" = 0; };
        }
        { #--{Memory configuration}------------#
            # Put /tmp/ on a tmpfs
            boot.tmp.useTmpfs = true;
            zramSwap = {
                # Put swap on compressed tmpfs
                enable = true;
                algorithm = "zstd";
            };
        }
        { #--{Virtualization Configuration}----#
            virtualisation.podman = {
                enable = true;
                dockerCompat = true;
                dockerSocket.enable = true;
            };
        }
        { #--{Network Configuration}-----------#
            #? Consider switching to networkd
            networking = {
                firewall.enable = true;
                networkmanager.enable =true;
                nameservers = [
                    "1.1.1.1" "1.0.0.1"
                    "2606:4700:4700::1111"
                    "2606:4700:4700::1001"
                ];
            };
            # Start NetworkManager during boot but Avoid waiting for a lease
            #systemd.services.NetworkManager-wait-online.enable = false;
            systemd.services.NetworkManager.enable = true;
            boot.kernelModules = [ "tcp_bbr" ];
            boot.kernel.sysctl = {
                # Prevent bogus ICMP errors from filling up logs.
                "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
                # Reverse path filtering causes the kernel to do source validation of
                # packets received from all interfaces. This can mitigate IP spoofing.
                "net.ipv4.conf.default.rp_filter" = 1;
                "net.ipv4.conf.all.rp_filter" = 1;
                # Do not accept IP source route packets (we're not a router)
                "net.ipv4.conf.all.accept_source_route" = 0;
                "net.ipv6.conf.all.accept_source_route" = 0;
                # Don't send ICMP redirects (again, we're on a router)
                "net.ipv4.conf.all.send_redirects" = 0;
                "net.ipv4.conf.default.send_redirects" = 0;
                # Refuse ICMP redirects (MITM mitigations)
                "net.ipv4.conf.all.accept_redirects" = 0;
                "net.ipv4.conf.default.accept_redirects" = 0;
                "net.ipv4.conf.all.secure_redirects" = 0;
                "net.ipv4.conf.default.secure_redirects" = 0;
                "net.ipv6.conf.all.accept_redirects" = 0;
                "net.ipv6.conf.default.accept_redirects" = 0;
                # Protects against SYN flood attacks
                "net.ipv4.tcp_syncookies" = 1;
                # Incomplete protection again TIME-WAIT assassination
                "net.ipv4.tcp_rfc1337" = 1;
                # Enable TCP fastopen
                "net.ipv4.tcp_fastopen" = 3;
                # Queueing discipline and congestion control
                # Bufferbloat mitigations + slight improvement in throughput & latency
                "net.core.default_qdisc" = "cake";
                "net.ipv4.tcp_congestion_control" = "bbr";
            };
        }
        { #--{System Security Considerations}--#
            #? Consider adding apparmor
            security = {
                # Prevent replacing the running kernel w/o reboot
                protectKernelImage = true;
                polkit.enable = true;
                sudo = {
                    enable = true;
                    execWheelOnly = true;
                    wheelNeedsPassword = false;
                };
                auditd.enable = true;
                audit = {
                    enable = true;
                    rules = [
                        "-a exit,always -F arch=b64 -S execve"
                    ];
                };
            };
        }
        { #--{System Services}-----------------#
            systemd.oomd = {
                # RHEL-Like oomd behavior
                enableRootSlice = true;
                enableUserServices = true;
            };
            services = {
                openssh = {
                    enable = true;
                    settings = {
                        PermitRootLogin = lib.mkForce "no";
                        PasswordAuthentication = lib.mkForce false;
                        KbdInteractiveAuthentication = false;
                    };
                };
                resolved = {
                    enable = true;
                };
            };
        }
    ]);
}