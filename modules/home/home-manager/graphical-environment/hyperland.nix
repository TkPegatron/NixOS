{ pkgs, lib, ...}:{
    config = (lib.mkMerge [
        { # QT Configuration
            qt.enable = true;
            qt.platformTheme.name = "gtk";
        }
        { # GTK Configuration
            gtk.enable = true;
            gtk.theme = {
                name = "Catppuccin-Mocha-Standard-Blue-Dark";
                package = pkgs.catppuccin-gtk.override {
                    accents = [ "blue" ];
                    tweaks = [ "rimless" ];
                    variant = "mocha";
                };
            };
            gtk.iconTheme = {
                name = "Papirus-Dark";
                package = pkgs.papirus-icon-theme;
            };
            gtk.cursorTheme = {
                name = "Bibata-Modern-Classic";
                package = pkgs.bibata-cursors;
            };
        }
        {
            home.sessionVariables = {
                QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
                XDG_CURRENT_DESKTOP = "Hyprland";
                XDG_SESSION_DESKTOP = "Hyprland";
                XDG_SESSION_TYPE = "wayland";
                QT_QPA_PLATFORM = "wayland";
                MOZ_ENABLE_WAYLAND = "1";
            };
        }
        { # Hyperland Configuration
            xdg.configFile."kitty".source = ../../../../config/kitty;
            xdg.configFile."waybar".source = ../../../../config/waybar;
            xdg.configFile."hypr".source = ../../../../config/hypr;
        }
    ]);
}