{ inputs, pkgs, config, ... }: {
    imports = [
        ./base_system.nix
        ./graphical.nix
        ./networking.nix
        ./pkgmgmt.nix
        ./users.nix
    ];
}
