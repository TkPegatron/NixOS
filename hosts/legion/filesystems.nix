{ config, lib, pkgs, ... }: {
    boot.supportedFilesystems = [ "ntfs" ];
    boot.initrd.luks.devices = {
        # Boot drive
        "legion-root".device = "/dev/disk/by-uuid/035b8987-6748-4303-bfe3-07df0149e40a";
        # Game Drives
        "ssd-500gb".device = "/dev/disk/by-uuid/58dbcd2a-46ae-42ed-be74-95063e01ee1f";
        "ssd-1000gb".device = "/dev/disk/by-uuid/4a158f14-9176-46dc-abcb-fe0a8185b243";
        # Media Drives
        "3429c15310f1".device = "/dev/disk/by-uuid/a9c4d07f-17a7-4da7-821a-3429c15310f1";
    };

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/c867ce92-abe1-4d39-89e0-f39c4e2afa86";
        fsType = "btrfs";
        options = [ "subvol=root" "noatime" "discard" "compress=zstd" ];
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

    fileSystems."/media" = {
        device = "/dev/disk/by-uuid/d0b57649-3fca-4cef-b1ee-ab5f5e4acfbe";
        fsType = "ext4";
    };

    fileSystems."/var/drives/tibssd" = {
        device = "/dev/disk/by-uuid/7cbb20d2-c627-4222-8177-26599703fe00";
        fsType = "btrfs";
    };

    fileSystems."/var/drives/gibssd" = {
        device = "/dev/disk/by-uuid/ce6d8e4e-d224-446c-95d9-6d8fcd26bc1a";
        fsType = "btrfs";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/0491-D7C3";
        fsType = "vfat";
    };

    swapDevices = [ ];
}
