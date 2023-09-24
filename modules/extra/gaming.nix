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
      # Allow unfree steam installation
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "steam" ];
      # Install Steam and Valve udev rules
      programs.steam.enable = true;
      hardware.steam-hardware.enable = true;
      # Feralinteractive Gamemode
      programs.gamemode.enable = true;
      # Install MangoHUD
      environment.systemPackages = with pkgs; [ mangohud ];
    }
    { #--{ Install Glorious Egroll Proton }-----------------#
      nixpkgs.overlays = [
        (_: prev: {
          steam = prev.steam.override {
            extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${inputs.nix-gaming.packages.${pkgs.system}.proton-ge}'";
          };
        })
      ];
      environment.systemPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      ];
    }
  ]);
}