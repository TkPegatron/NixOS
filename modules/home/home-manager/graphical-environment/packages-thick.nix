{ pkgs, lib, ... }: {
    config = (lib.mkMerge [
        {
            services.flatpak = {
                update.auto = {
                    enable = true;
                    onCalendar = "weekly";
                };
                packages = [
                    "com.github.tchx84.Flatseal"
                    "dev.k8slens.OpenLens"
                    "dev.vencord.Vesktop"
                    "com.discordapp.Discord"
                    "org.inkscape.Inkscape"
                    "org.kde.krita"
                    "org.gimp.GIMP"
                    "org.gnome.meld"
                    "org.wireshark.Wireshark"
                ];
                overrides.global = {
                    Context.sockets = ["wayland" "x11" "fallback-x11"];
                    Environment = {
                        # Fix un-themed cursor in some Wayland apps
                        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
                        # Force correct theme for some GTK apps
                        GTK_THEME = "Adwaita:dark";
                        # Tell electron to use ozone platform hinting
                        ELECTRON_OZONE_PLATFORM_HINT = "auto";
                    };
                };
            };
        }
        { # Flatpak: Vivaldi
            services.flatpak = {
                packages = [ "com.vivaldi.Vivaldi" ];
                overrides."com.vivaldi.Vivaldi".Context = {
                    sockets = [ "!wayland" "!fallback-x11" "x11" "gpg-agent" "pcsc" ];
                };
            };
        }
        #{ # Flatpak: VSCode
        #    services.flatpak = {
        #        packages = [
        #            "com.visualstudio.code"
        #            "runtime/com.visualstudio.code.tool.podman/x86_64/23.08"
        #        ];
        #        overrides."com.visualstudio.code".Context = {
        #            filesystems = [
        #                "xdg-config/git:ro" # Expose user Git config
        #                "xdg-run/podman" # Allow the use of podman api
        #                "/run/current-system/sw/bin:ro" # Expose NixOS managed software
        #            ];
        #            sockets = [
        #                "!wayland" # Allowing vscode to use wayland is an awkward experience
        #                "x11"
        #                "fallback-x11"
        #                "gpg-agent" # Expose GPG agent
        #                "pcsc" # Expose smart cards (i.e. YubiKey)
        #            ];
        #        };
        #    };
        #}
        {
            programs.vscode = {
                enable = true;
                enableUpdateCheck = false; # It is annoying
                extensions = with pkgs.vscode-extensions; [
                    bbenoist.nix
                    aaron-bond.better-comments
                    oderwat.indent-rainbow
                ];
            };
        }
        #{ # Misc Apps, these could be switched out for flatpaks
        #    home.packages = with pkgs; [ 
        #        discord
        #        openlens
        #        krita
        #        gimp
        #        inkscape
        #        meld
        #        wireshark
        #    ];
        #}
        #{ # Web Browser: Vivaldi
        #    home.packages = with pkgs; [
        #        (vivaldi.override {
        #            proprietaryCodecs = true;
        #            enableWidevine = true;
        #        })
        #    ];
        #}
        #{ # Coding: VSCode
        #    programs.vscode.enable = true;
        #    programs.vscode.package = with pkgs; pkgs.vscode;
        #    home.sessionVariables.NIXOS_OZONE_WL = "1";
        #}
        {
            dconf.settings = {
                "org/virt-manager/virt-manager/connections" = {
                  autoconnect = [ "qemu:///system" ];
                  uris = [ "qemu:///system" ];
                };
            };
        }
    ]);
}
