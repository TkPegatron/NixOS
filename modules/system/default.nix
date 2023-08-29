{ inputs, pkgs, config, ... }: {
    imports = [
        ./auditd.nix
        ./base_system.nix
        ./graphical.nix
        ./networking.nix
        ./pkgmgmt.nix
        ./users.nix
    ];
}
