{ home-manager, user, desktop, inputs, ... }: {
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit user desktop inputs; };
        backupFileExtension = "backup";
        users."${user.username}" = {
            imports = [
                inputs.nix-flatpak.homeManagerModules.nix-flatpak
                ./env.nix
                ./xdg.nix
                ./shell-environment
                ./graphical-environment
                ./users/${user.username}
            ];
            home.stateVersion = "24.05";
            programs.home-manager.enable = true;
        };
    };
}