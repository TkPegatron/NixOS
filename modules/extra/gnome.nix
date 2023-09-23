{ pkgs, ... }: {
  imports = [ ./init5.nix ];
  # Configure NixOS to start GDM
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm.enable = true;
      gdm.wayland = true;
      autoLogin.enable = true;
      autoLogin.user = "elliana";
    };
  };
  # Strip out unwanted gnome packages
  environment.gnome.excludePackages = with pkgs.gnome; [
    gnome-initial-setup gnome-music
    gnome-weather simple-scan totem epiphany geary
    yelp tali cheese
  ];
}
