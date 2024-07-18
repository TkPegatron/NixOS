{ pkgs, ... }: {
    services.gnome-keyring.enable = true;
    services.gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;
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
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };
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