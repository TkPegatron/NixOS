{config, lib, pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        kodi
        kodi-cli
        kodi-wayland
        kodiPackages.vfs-sftp
        kodiPackages.signals
        kodiPackages.routing
        kodiPackages.youtube
        kodiPackages.invidious
        kodiPackages.sponsorblock
        kodiPackages.upnext
    ];
}
