{ config, lib, pkgs, modulesPath, ... }: {
    imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
        (./impermanence.nix)
    ];

    boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    boot.initrd.luks.devices = {
        "nixos-system".device = "/dev/disk/by-uuid/f2148c2a-7885-43f3-84e1-57d33f4c1ce1";
    };

    fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
        options = [ "size=2G" "mode=755" ];
    };

    fileSystems."/home" = {
        fsType = "btrfs";
        options = [ "subvol=home" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/50794c99-9df5-41ff-92b8-700e7da4b6fe";
    };

    fileSystems."/persist" = {
        fsType = "btrfs";
        options = [ "subvol=persist" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/50794c99-9df5-41ff-92b8-700e7da4b6fe";
    };

    fileSystems."/nix" = {
        fsType = "btrfs";
        options = [ "subvol=nix" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/50794c99-9df5-41ff-92b8-700e7da4b6fe";
    };

    fileSystems."/var/log" = {
        fsType = "btrfs";
        options = [ "subvol=log" "noatime" "discard" "compress=zstd" ];
        device = "/dev/disk/by-uuid/50794c99-9df5-41ff-92b8-700e7da4b6fe";
    };

    fileSystems."/boot" = {
        fsType = "vfat";
        device = "/dev/disk/by-uuid/4292-E521";
    };

    # Do not use swap device
    swapDevices = [];

    system.stateVersion = "23.05";
}