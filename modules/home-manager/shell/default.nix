{ pkgs, lib, config, ... }:
with lib;
let 
    cfg = config.modules.shell;

    sudoAliases = {
        sodu  = "sudo env PATH=$PATH "; # Sudo is cruise control for cool
        sodo  = "sudo env PATH=$PATH "; # Preserve PATH and aliases
        sdoo  = "sudo env PATH=$PATH "; # Preserve PATH and aliases
        sudu  = "sudo env PATH=$PATH "; # Preserve PATH and aliases
        sduo  = "sudo env PATH=$PATH "; # Preserve PATH and aliases
        sudo  = "sudo env PATH=$PATH "; # Preserve PATH and aliases
    };

    generalAliases = {
        cat   = "bat -Pp";              # Use bat instead of cat
        ip    = "ip --color=auto";      # Color IP command
        mkdir = "mkdir -pv";            # Always create directory trees
    };

in {
    options.modules.shell = { enable = mkEnableOption "shell"; };
    imports = mkIf cfg.enable [ ./cli-apps.nix ];
    config = mkIf cfg.enable (lib.mkMerge [
        { #--{Shell Related Packages}--------#
            home.packages = with pkgs; [
                skim fd perl ripgrep-all
                bottom
            ];
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
                    enableZshIntegration = true;
                };
            };
        }
        { #--{Session Environment}-----------#
            home.sessionVariables = {
                LANG = "en_US.UTF-8";
                PAGER = "less -FirSwX";
                MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
            };
            home.sessionPath = [
                "${config.home.homeDirectory}/.local/bin"
            ];
        }
        { #--{XDG Enforcement}---------------#
            xdg = {
                enable = true;
                userDirs = {
                    enable = true;
                    createDirectories = true;
                    desktop = "${config.home.homeDirectory}/.desktop";
                    documents = "${config.home.homeDirectory}/Documents";
                    pictures = "${config.home.homeDirectory}/Pictures";
                    videos = "${config.home.homeDirectory}/Videos";
                    music = "${config.home.homeDirectory}/Music";
                };
            };
        }
        { #--{Starship PS1 Configuration}----#
            programs.starship.enable = true;
            xdg.configFile = {
                "starship.toml".text = builtins.readFile ./config/starship.toml;
            };
        }
        { #--{ZShell Configuration}----------#
            programs= {
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
                        path = "${config.xdg.dataHome}/zsh/history";
                    };
                    shellAliases = generalAliases // sudoAliases;
                    envExtra = ''
                        ZSH_SELF_EXAPWD=true
                        STARSHIP_OS_ICON=""
                    '';
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
                        {
                            name = "skim.plugin";
                            file = "skim.plugin.zsh";
                            src = fetchFromGitHub {
                                owner = "casonadams";
                                repo = "skim.zsh";
                                rev = "994a8bbc82c1c12fbb20ba0964dbd7a0cacc3b1e";
                                sha256 = "sha256-fN7mpWIM6r+RkQZZnMH4uRb5Wge7AwmYEzwsrhibeU8=";
                            };
                        }
                        {
                            name = "zsh-history-substring-search";
                            file = "zsh-history-substring-search.zsh";
                            src = fetchFromGitHub {
                                owner = "zsh-users";
                                repo = "zsh-history-substring-search";
                                rev = "v1.0.2";
                                sha256 = "sha256-Ptxik1r6anlP7QTqsN1S2Tli5lyRibkgGlVlwWZRG3k=";
                            };
                        }
                        {
                            name = "zsh-completions";
                            src = fetchFromGitHub {
                                owner = "zsh-users";
                                repo = "zsh-completions";
                                rev = "0.33.0";
                                sha256 = "sha256-cQSKjQhhOm3Rvnx9V6LAmtuPp/ht/O0IimpunoQlQW8=";
                            };
                        }
                    ];
                };
            };
        }
    ]);
}