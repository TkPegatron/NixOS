{ user, inputs, ... }: {
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit user inputs; };
        users."${user.username}" = {
            imports = [
                "./${user.username}"
                ./packages.nix
                ./zshell.nix
            ];
            home.stateVersion = "24.05";
            programs.home-manager.enable = true;
        }
    }
}