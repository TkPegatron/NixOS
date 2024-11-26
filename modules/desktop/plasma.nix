{ pkgs, ... }: {
  # Configure NixOS to start GDM
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.wayland.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
  ];
}
