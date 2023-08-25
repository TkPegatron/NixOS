{ config, pkgs, lib, inputs, ... }:
with lib;
let cfg = config.modules.gnome;
in {
    options.modules.gnome = { enable = mkEnableOption "gnome"; };
    config = mkIf cfg.enable (lib.mkMerge [
        {
            services.gnome-keyring.enable = true;
            home.packages = with pkgs; [
                dconf2nix
                yubikey-manager-qt
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
        {
            dconf.settings = {
                "org/gnome/desktop/interface" = {
                    monospace-font-name = "CaskaydiaCove Nerd Font Mono 10";
                    show-battery-percentage = true;
                    color-scheme = "prefer-dark";
                    locate-pointer = true;
                };
                "org/gnome/desktop/peripherals/touchpad" = {
                    two-finger-scrolling-enabled = true;
                    tap-to-click = true;
                };
                "org/gnome/desktop/wm/preferences" = {
                    button-layout = "appmenu:minimize,maximize,close";
                };
            };
        }
    ]);
}
