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
    { #--{ Install Steam and some optionals }-----------------#
      # Install Steam and Valve udev rules
      programs.steam.enable = true;
      hardware.steam-hardware.enable = true;
      # Feralinteractive Gamemode
      programs.gamemode.enable = true;
      # Install MangoHUD
      environment.systemPackages = with pkgs; [ mangohud ];
    }
    { #--{ Minecraf launcher and configuration }------------#
      # This could be moved into the userspace
      environment.systemPackages = with pkgs; [
        prismlauncher
      ];
    }
    { #--{ Install Glorious Egroll Proton }-----------------#
      environment.systemPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      ];
    }
    { #--{ Dark and Darker }-----------------#
      environment.systemPackages = with pkgs; [
        #lutris
        samba4Full
        glibc
      ];
    }
  ]);
}
