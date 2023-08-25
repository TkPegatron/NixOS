{ config, lib, inputs, pkgs, ... }: {
    # Enable amdgpu driver usage in graphical server
    services.xserver.videoDrivers = [ "amdgpu" ];

    # Steam with VR Udev Rules
    programs.steam.enable = true;
    hardware.steam-hardware.enable = true;

    # Vulkan OpenGL support
    hardware.opengl = {
        driSupport = true;
        extraPackages = with pkgs; [ amdvlk ];
        driSupport32Bit = true;
        extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
    
    # Proton-GE
    environment.systemPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    ];
    nixpkgs.overlays = [
        (_: prev: {
            steam = prev.steam.override {
                extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${inputs.nix-gaming.packages.${pkgs.system}.proton-ge}'";
            };
        })
    ];
    
    # Feralinteractive Gamemode
    programs.gamemode.enable = true;
}
