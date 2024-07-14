{ home-manager, user, desktop, inputs, ... }: {
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit user desktop inputs; };
        users."${user.username}" = {
            imports = [
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