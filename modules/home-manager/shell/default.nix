{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.shell;
in {
    options.modules.shell = { enable = mkEnableOption "shell"; };
    config = mkIf cfg.enable (lib.mkMerge [
        { #--{Shell Related Packages}--------#
            programs = {
                home-manager.enable = true;
                exa = {
                    enable = true;
                    enableAliases = true;
                };
                bat = {
                  enable = true;
                  config = {
                    theme = "TwoDark";
                    map-syntax = [
                      ".ignore:Git Ignore"
                      ".stignore:Git Ignore"
                    ];
                  };
                };
                direnv = {
                    enable = true;
                    nix-direnv.enable = true;
                }
            };
        }
        { #--{Session Environment}-----------#
            home.sessionVariables = {
                LANG = "en_US.UTF-8";
            };
        }
        { #--{XDG Enforcement}---------------#
            xdg = {
                enable = true;
                userDirs = {
                    desktop = "$HOME/.desktop";
                };
                configFile = {
                    "starship.toml".text = builtins.readFile ./config/starship.toml;
                };
            };
        }
        { #--{ZShell Configuration}----------#
            programs= {
                starship.enable = true;
                zsh = {
                    enable = true;
                    autocd = true;
                    enableAutosuggestions = true;
                };
            };
        }
    ]);
}