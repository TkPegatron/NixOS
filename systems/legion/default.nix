
{ config, lib, inputs, pkgs, ... }: {
    imports = [
        ./filesystems.nix
        #./syncthing.nix
    ];

    system.stateVersion = "23.05";

    # Include AMD Microcode
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # Include wifi firmware, among other things
    hardware.enableRedistributableFirmware = true;


    # Enable amdgpu driver usage in graphical server
    services.xserver.videoDrivers = [ "amdgpu" ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];


    # Use the systemd-boot EFI boot loader.
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    # Fancy boot graphics
    boot.plymouth = {
        enable = true;
        #themePackages = [self'.packages.catppuccin-plymouth];
        #theme = "catppuccin-mocha";
    };
}
