{ inputs, pkgs, config, ... }: {
    imports = [
        ./base_system.nix
        ./users.nix
    ];
}