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
        llo   = "${pkgs.lsd}/bin/lsd --long --permissions octal";   # Show octal permissions
        cat   = "bat -Pp";                                  # Use bat instead of cat
        ip    = "ip --color=auto";                          # Color IP command
        mkdir = "mkdir -pv";                                # Always create directory trees
    };

in {
    options.modules.shell = { enable = mkEnableOption "shell"; };
    imports = [ ./cli-apps.nix ];
    config = mkIf cfg.enable (lib.mkMerge [
        { #--{Shell Related Packages}--------#
            home.packages = with pkgs; [
                skim fd perl #ripgrep-all
                bottom
            ];
            programs = {
                home-manager.enable = true;
                lsd = {
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
                    extraPackages = with pkgs.bat-extras; [
                        batdiff batman batwatch batwatch
                    ];
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
                    autosuggestion.enable = true;
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
                        ZSH_SELF_LSPWD=true
                        STARSHIP_OS_ICON=""
                    '';
                    initExtra = lib.concatMapStrings builtins.readFile [
                        ./config/zshrc
                    ];
                    plugins = [
                        {
                            name = "F-Sy-H";
                            src = builtins.fetchGit {
                                url = "https://github.com/z-shell/F-Sy-H";
                                rev = "899f68b52b6b86a36cd8178eb0e9782d4aeda714";
                            };
                        }
                        {
                            name = "zsh-history-substring-search";
                            src = builtins.fetchGit {
                                url = "https://github.com/zsh-users/zsh-history-substring-search";
                                rev = "400e58a87f72ecec14f783fbd29bc6be4ff1641c";
                                # tag = v1.1.0
                            };
                        }
                        {
                            name = "zsh-completions";
                            src = builtins.fetchGit {
                                url = "https://github.com/zsh-users/zsh-completions";
                                rev = "67921bc12502c1e7b0f156533fbac2cb51f6943d";
                                # tag = 0.35.0
                            };
                        }
                        {
                            name = "zsh-autosuggestions";
                            src = builtins.fetchGit {
                                url = "https://github.com/zsh-users/zsh-autosuggestions";
                                rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
                                # tag = v0.7.0
                            };
                        }
                        {
                            name = "skim";
                            file = "skim.plugin.zsh";
                            src = builtins.fetchGit {
                                url = "https://github.com/casonadams/skim.zsh";
                                rev = "994a8bbc82c1c12fbb20ba0964dbd7a0cacc3b1e";
                                # tag = 
                            };
                        }
                    ];
                };
            };
        }
    ]);
}
