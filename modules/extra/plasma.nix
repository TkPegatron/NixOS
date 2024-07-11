{ pkgs, ... }: {
  imports = [ ./init5.nix ];
  # Configure NixOS to start GDM
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.displayManager.sddm.wayland.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
  ];
}
