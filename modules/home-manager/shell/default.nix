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
    imports = [ ./cli-apps.nix ];
    config = mkIf cfg.enable (lib.mkMerge [
        { #--{Shell Related Packages}--------#
            home.packages = with pkgs; [
                skim fd perl #ripgrep-all
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
                    zplug = {
                        enable = true;
                        plugins = [
                            { name = "belak/zsh-utils"; tags = [ use:completion ]; }
                            { name = "zsh-users/zsh-history-substring-search"; }
                            { name = "zsh-users/zsh-autosuggestions"; }
                            { name = "zsh-users/zsh-completions"; }
                            { name = "casonadams/skim.zsh"; }
                            { name = "z-shell/F-Sy-H"; }
                        ];
                    };
                };
            };
        }
    ]);
}