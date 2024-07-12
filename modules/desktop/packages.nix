{ pkgs, ... }: {
  services.flatpak.enable = true;
  # Install desired system graphical packages
  environment.systemPackages = with pkgs; [
    celluloid # MPV Frontend
    # Havent Decided between these two yet
    #qimgv libsForQt5.gwenview
  ];
}
