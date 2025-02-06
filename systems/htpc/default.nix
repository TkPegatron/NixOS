{ config, lib, inputs, pkgs, ... }: {
    imports = [
        ./filesystems.nix
        inputs.nixos-hardware.nixosModules.raspberry-pi-4
        ./kodi-media-center.nix
    ];

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

    boot.plymouth.enable = true;
    boot.kernelParams = [ "snd_bcm2835.enable_hdmi=1" "snd_bcm2835.enable_headphones=1" ];
    boot.loader.raspberryPi.firmwareConfig = ''dtparam=audio=on'';
    boot.loader.generic-extlinux-compatible.enable = lib.mkForce true;
    boot.loader.systemd-boot.enable = lib.mkForce false;

    hardware = {
        enableRedistributableFirmware = true;
        raspberry-pi."4" = {
            fkms-3d.enable = true;
            apply-overlays-dtmerge.enable = true;
        };
        deviceTree = {
            enable = true;
            filter = lib.mkForce "*rpi-4-*.dtb";
        };
    };

    services.ivpn.enable = true;
    environment.systemPackages = with pkgs; [
        ivpn
        libraspberrypi
        raspberrypi-eeprom
    ];
}