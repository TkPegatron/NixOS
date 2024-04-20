{ config, lib, inputs, ... }: {
    # Submodule imports
    imports = [
        ./filesystems.nix
        ./wireguard.nix
        ./impermanence.nix
        ./syncthing.nix
    ];

    system.stateVersion = "23.05";

    # Include Intel Microcode
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # Include wifi firmware, among other things
    hardware.enableRedistributableFirmware = true;

    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    boot.plymouth = {
       enable = true;
       #themePackages = [self'.packages.catppuccin-plymouth];
       #theme = "catppuccin-mocha";
    };

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    # Set up agenix
    environment.systemPackages = [
        inputs.agenix.packages.x86_64-linux.default
    ];
}
