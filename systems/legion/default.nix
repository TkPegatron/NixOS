
{ config, lib, inputs, pkgs, ... }: {
    imports = [
        ./filesystems.nix
        ./syncthing.nix
        ./sshcerts.nix
        ./moonlander.nix
    ];

    # Include AMD Microcode
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # Include wifi firmware, among other things
    hardware.enableRedistributableFirmware = true;

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.extraModulePackages = [ ];

    # Use the systemd-boot EFI boot loader.
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    services.ivpn.enable = true;

    environment.systemPackages = with pkgs; [
      steamtinkerlaunch
      protonup-qt
      ivpn
      r2modman-upstream
      (lutris.override {
        extraLibraries =  pkgs: [
          # List library dependencies here
        ];
        extraPkgs = pkgs: [
          # List package dependencies here
        ];
      })
    ];

    programs.winbox = {
        enable = true;
        openFirewall = true;
        package = pkgs.winbox;
    };

    networking.firewall = {
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPortRanges = [
        {
          from = 40000;
          to = 50000;
        }
      ];
    };

    # Fancy boot graphics
    boot.plymouth = {
        enable = true;
        #themePackages = [self'.packages.catppuccin-plymouth];
        #theme = "mocha";
    };
}
