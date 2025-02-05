{ config, ... }: {
    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/12CE-A600";
        fsType = "vfat";
        options = ["noatime"];
    }
    fileSystems."/" = {
        device = "/dev/disk/by-uuid/5c148f7d-a921-4b61-a792-93808f12499b";
        fsType = "ext4";
        options = ["noatime"];
    }
}