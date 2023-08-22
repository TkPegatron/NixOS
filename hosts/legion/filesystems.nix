{ config, lib, pkgs, ... }: {
    boot.initrd.luks.devices = {
        "legion-root".device = "/dev/disk/by-uuid/035b8987-6748-4303-bfe3-07df0149e40a";
    };

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/c867ce92-abe1-4d39-89e0-f39c4e2afa86";
        fsType = "btrfs";
        options = [ "subvol=root" "noatime" "discard" "compress=zstd" ];
    };


    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/0491-D7C3";
        fsType = "vfat";
    };

    fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/c867ce92-abe1-4d39-89e0-f39c4e2afa86";
        fsType = "btrfs";
        options = [ "subvol=nix" "noatime" "discard" "compress=zstd" ];
    };

    fileSystems."/var/log" = {
        device = "/dev/disk/by-uuid/c867ce92-abe1-4d39-89e0-f39c4e2afa86";
        fsType = "btrfs";
        options = [ "subvol=log" "noatime" "discard" "compress=zstd" ];
    };

    fileSystems."/home" = {
        device = "/dev/disk/by-uuid/c867ce92-abe1-4d39-89e0-f39c4e2afa86";
        fsType = "btrfs";
        options = [ "subvol=home" "noatime" "discard" "compress=zstd" ];
    };

  swapDevices = [ ];
}