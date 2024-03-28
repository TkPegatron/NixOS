{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        winetricks
        wineWowPackages.stable
        wineWowPackages.waylandFull
    ];
}