{ config, lib, pkgs, ... }: {
    # MODEL,SERIAL,NAME,LABEL,TYPE,FSTYPE,FSVER,UUID,STATE,SIZE,FSAVAIL,FSUSE%,MOUNTPOINTS

    swapDevices = [ ];

    # Support NTFS (really I think this just tells nix we need the kernel module for ntfs)
    boot.supportedFilesystems = [ "ntfs" ];

    boot.initrd.systemd.enable = true;
    #boot.initrd.luks.fido2Support = true;
    boot.initrd.luks.devices = {
        # Enciphered Boot Drive
        "legion-root" = {
            device = "/dev/disk/by-uuid/60b78745-8483-41c7-bfd8-7460cd15c5a8";
            crypttabExtraOpts = [ "fido2-device=auto" ];
        };
        # Enciphered Steam Library Drives
        "samsung870evo-s625nj0r276483w" = {
            device = "/dev/disk/by-uuid/4a158f14-9176-46dc-abcb-fe0a8185b243";
            crypttabExtraOpts = [ "fido2-device=auto" ];
        };
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/D801-1410";
        fsType = "vfat";
    };

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/f66a8612-a74e-47e4-a94a-11e518969852";
        fsType = "btrfs";
        options = [ "subvol=root" "noatime" "discard" "compress=zstd" ];
    };

    fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/f66a8612-a74e-47e4-a94a-11e518969852";
        fsType = "btrfs";
        options = [ "subvol=nix" "noatime" "discard" "compress=zstd" ];
    };

    fileSystems."/var/log" = {
        device = "/dev/disk/by-uuid/f66a8612-a74e-47e4-a94a-11e518969852";
        fsType = "btrfs";
        options = [ "subvol=log" "noatime" "discard" "compress=zstd" ];
    };

    fileSystems."/home" = {
        device = "/dev/disk/by-uuid/f66a8612-a74e-47e4-a94a-11e518969852";
        fsType = "btrfs";
        options = [ "subvol=home" "noatime" "discard" "compress=zstd" ];
    };

    fileSystems."/var/drives/Samsung_SSD_870_EVO_1TB_S625NJ0R276483W" = {
        device = "/dev/disk/by-uuid/ee6215f2-f525-411a-b6bf-86d73ec82c4c";
        fsType = "btrfs";
    };
}
