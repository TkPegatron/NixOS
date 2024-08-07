{ config, lib, nixpkgs, inputs, pkgs, ... }: {
  config = lib.mkMerge ([
    { # Vulkan OpenGL support
      hardware.opengl = {
        driSupport = true;
        extraPackages = with pkgs; [ amdvlk ];
        driSupport32Bit = true;
        extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
      };
    }
    { #--{ OBS and v4l2loopback}
      environment.systemPackages = [
        (pkgs.wrapOBS {
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-backgroundremoval
            obs-pipewire-audio-capture
          ];
        })
      ];
      boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
      boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
      security.polkit.enable = true;
    }
    ##  Not using native steam. Flatpak more stable.
    #{ #--{ Install Steam and some optionals }-----------------#
    #  # Install Steam and Valve udev rules
    #  programs.steam = {
    #    enable = true;
    #    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    #    gamescopeSession.enable = true;
    #  };
    #  hardware.steam-hardware.enable = true;
    #  # Feralinteractive Gamemode
    #  programs.gamemode.enable = true;
    #  # Install MangoHUD
    #  environment.systemPackages = with pkgs; [ mangohud ];
    #}
    { #--{ Minecraft launcher and configuration }------------#
      # This could be moved into the userspace
      environment.systemPackages = with pkgs; [
        prismlauncher
      ];
    }
    { #--{ Dark and Darker }-----------------#
      environment.systemPackages = with pkgs; [
        #lutris
        samba4Full
        glibc
      ];
    }
    { #--{ Mod Managers }----------------------#
      environment.systemPackages = with pkgs; [
        r2modman-upstream
      ];
    }
  ]);
}
