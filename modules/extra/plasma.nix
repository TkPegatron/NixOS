{ pkgs, ... }: {
  imports = [ ./init5.nix ];
  # Configure NixOS to start GDM
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    #displayManager.defaultSession = "plasmawayland";
  };
}
