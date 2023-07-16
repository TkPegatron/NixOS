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
                };
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
                    dotDir = ".config/zsh";
                    enableAutosuggestions = true;
                    history = {
                        size = 500000;
                        save = 500000;
                        extended = false;
                        ignoreSpace = true;
                        ignoreDups = true;
                        share = true;
                        path = ".config/zsh/zsh_history";
                    };
                    initExtra = lib.concatMapStrings builtins.readFile [
                        ./config/zshrc
                    ];
                    plugins = with pkgs; [
                        {
                            name = "F-Sy-H";
                            src = fetchFromGitHub {
                                #url = "https://github.com/z-shell/F-Sy-H.git";
                                owner = "z-shell";
                                repo = "F-Sy-H";
                                sha256 = "sha256-zhaXjrNL0amxexbZm4Kr5Y/feq1+2zW0O6eo9iZhmi0=";
                                rev = "v1.67";
                            };
                        }
                    ];
                };
            };
        }
    ]);
}