{ config, lib, pkgs, ... }: {
    boot.initrd.luks.devices = {
        "nixos-system".device = "/dev/disk/by-uuid/a07609af-3065-409b-854f-686c366b0521";
    };

    fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
        options = [ "size=2G" "mode=755" ];
    };

    fileSystems."/home" = {
        fsType = "btrfs";
        options = [ "subvol=home" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/578b581b-4e92-4999-8317-30d42f42adea";
    };

    fileSystems."/persist" = {
        fsType = "btrfs";
        neededForBoot = true;
        options = [ "subvol=persist" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/578b581b-4e92-4999-8317-30d42f42adea";
    };

    fileSystems."/nix" = {
        fsType = "btrfs";
        options = [ "subvol=nix" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/578b581b-4e92-4999-8317-30d42f42adea";
    };

    fileSystems."/var/log" = {
        fsType = "btrfs";
        options = [ "subvol=log" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/578b581b-4e92-4999-8317-30d42f42adea";
    };

    fileSystems."/boot" = {
        fsType = "vfat";
        device = "/dev/disk/by-uuid/A4AE-7BEC";
    };

    # Do not use swap device
    swapDevices = [];
}