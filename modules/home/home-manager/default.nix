{ home-manager, user, inputs, ... }: {
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit user inputs; };
        users."${user.username}" = {
            imports = [
                ./env.nix
                ./git.nix
                ./gpg.nix
                ./nvim.nix
                ./packages.nix
                ./xdg.nix
                ./shell-environment
                ./${user.username}
            ];
            home.stateVersion = "24.05";
            programs.home-manager.enable = true;
        };
    };
}