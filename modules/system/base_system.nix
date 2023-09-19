{ config, pkgs, lib, inputs, ... }: {
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
                        monospace = ["CaskaydiaCove Nerd Font Mono"];
                        emoji = [ "OpenMoji Color" ];
                    };
                };
            };
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
            environment.systemPackages = with pkgs; [ podman-compose ];
            virtualisation.podman = {
                enable = true;
                dockerCompat = true;
                dockerSocket.enable = true;
            };
        }
        { #--{System Packages}-----------------#
            environment.systemPackages = with pkgs; [
                jq jqp ijq yq # JSON/YAML Query tools
                rsync
                dogdns
            ];
        }
        { #--{Package Aliases}-----------------#
            environment.systemPackages = with pkgs; [
                # Use dogdns as nslookup
                (pkgs.writeShellScriptBin "nslookup" "exec -a $0 ${dogdns}/bin/dog $@")
            ];
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
