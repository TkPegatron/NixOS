{ config, pkgs, lib, inputs, ... }:
with lib;
let cfg = config.modules.gnome;
in {
    options.modules.gnome = { enable = mkEnableOption "gnome"; };
    config = mkIf cfg.enable (lib.mkMerge [
        {
            #services.gnome-keyring.enable = true;
            home.packages = with pkgs; [
                # Gnome Extensions
                gnomeExtensions.unite
                gnomeExtensions.espresso
                gnomeExtensions.just-perfection
                gnomeExtensions.dash-to-dock
                gnome.gnome-tweaks
                # Resources Themes
                numix-cursor-theme
                tela-icon-theme
            ];
        }
        {
            qt.enable = true;
            qt.platformTheme = "gnome";
            qt.style.name = "adwaita-dark";
        }
    ]);
}