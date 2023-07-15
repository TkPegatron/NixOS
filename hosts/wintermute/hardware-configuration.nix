{ config, lib, pkgs, modulesPath, ... }: {
    imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    boot.loader = {
        plymouth.enable = true;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    boot.initrd.luks.devices = {
        "nixos-system".device = "/dev/disk/by-uuid/51f154bc-185b-404b-a5c0-7db68c33b006";
    };

    fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
        options = [ "size=2G" "mode=755" ];
    };

    fileSystems."/home" = {
        fsType = "btrfs";
        options = [ "subvol=home" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/8911ebf5-c49a-435e-bc98-dec5939e8b27";
    };

    fileSystems."/persist" = {
        fsType = "btrfs";
        options = [ "subvol=persist" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/8911ebf5-c49a-435e-bc98-dec5939e8b27";
    };

    fileSystems."/nix" = {
        fsType = "btrfs";
        options = [ "subvol=nix" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/8911ebf5-c49a-435e-bc98-dec5939e8b27";
    };

    fileSystems."/var/log" = {
        fsType = "btrfs";
        options = [ "subvol=log" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/8911ebf5-c49a-435e-bc98-dec5939e8b27";
    };

    fileSystems."/boot" = {
        fsType = "vfat";
        device = "/dev/disk/by-uuid/5E78-CDB9";
    };

    system.stateVersion = "23.05"
}