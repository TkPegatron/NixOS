{ config, lib, inputs, pkgs, ... }: {
    imports = [
        inputs.nixos-hardware.nixosModules.raspberry-pi-4
        ./filesystems.nix
    ];
    boot.plymouth.enable = true;
    boot.kernelParams = [ "snd_bcm2835.enable_hdmi=1" "snd_bcm2835.enable_headphones=1" ];
    boot.loader.raspberryPi.firmwareConfig = ''dtparam=audio=on'';

    hardware = {
        enableRedistributableFirmware = true;
        raspberry-pi."4" = {
            fkms-3d.enable = true;
            apply-overlays-dtmerge.enable = true;
            deviceTree = {
                enable = true;
                filter = "*rpi-4-*.dtb";
            };
        };
    };

    services.ivpn.enable = true;
    environment.systemPackages = with pkgs; [
        ivpn
        libraspberrypi
        raspberrypi-eeprom
    ];

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    boot.loader.generic-extlinux-compatible.enable = true;
    system.stateVersion = "25.05";
}