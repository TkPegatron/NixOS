{ config, lib, inputs, pkgs, ... }: {
    imports = [
        inputs.nixos-hardware.nixosModules.raspberry-pi-4
    ];
}