{ lib, pkgs, ... }: {
  imports = [ ./audit.nix ./network.nix ./pkgman.nix ./users.nix ];
  config = lib.mkMerge ([
    { #--{Kernel Configuration}------------#
      boot.kernel.sysctl = { "kernel.sysrq" = 0; }; # Disable SysRq keychord
    }
    { #--{Memory configuration}------------#
      boot.tmp.useTmpfs = true; # Use RAM for /tmp/
      zramSwap = { # Use compressed ram for swapping
        enable = true; algorithm = "zstd";
      };
    }
    { #--{System Services}-----------------#
      services.resolved.enable = true;
      services.openssh.enable = true;
      services.openssh.settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
      # RHEL-Like oomd behavior
      systemd.oomd = {
        enableRootSlice = true;
        enableUserServices = true;
      };
    }
    { #--{System Security Considerations}--#
        #? Consider adding apparmor
        security.protectKernelImage = true; # Prevent replacing the running kernel w/o reboot
        security.polkit.enable = true; # Enable Policykit
        security.sudo = { # Configure Sudo
          enable = true;
          execWheelOnly = true;
          wheelNeedsPassword = false;
        };
    }
    {
      environment.systemPackages = with pkgs; [
        nix-prefetch pinentry
        #genpass
      ];
    }
    { #--{Locale Configuration}------------#
        time.timeZone = "America/Detroit";
        i18n.defaultLocale = "en_US.UTF-8";
        console.keyMap = "us";
        fonts = {
            fonts = with pkgs; [
                (nerdfonts.override { fonts = [ "CascadiaCode" "OpenDyslexic" "Noto"]; })
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
  ]);
}
