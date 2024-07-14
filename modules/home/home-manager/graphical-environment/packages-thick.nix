{ pkgs, ... }: {
    (lib.mkMerge [
        { # Misc Apps, these could be switched out for flatpaks
            home.packages = with pkgs; [ 
                discord
                openlens
                krita
                gimp
                inkscape
                meld
                wireshark
            ];
        }
        { # Web Browser: Vivaldi
            home.packages = with pkgs; [
                (vivaldi.override {
                    proprietaryCodecs = true;
                    enableWidevine = true;
                })
            ];
        }
        { # Coding: VSCode
            programs.vscode.enable = true;
            programs.vscode.package = with pkgs; pkgs.vscode;
            home.sessionVariables.NIXOS_OZONE_WL = "1";
        }
    ]);
}