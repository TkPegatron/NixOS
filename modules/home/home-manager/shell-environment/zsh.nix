{ config, lib, pkgs, ... }:
let
    sudoAlias = "sudo env PATH=$PATH "; # Preserve PATH and aliases
    sudoAliases = {
        sodu  = sudoAlias;
        sodo  = sudoAlias;
        sdoo  = sudoAlias;
        sudu  = sudoAlias;
        sduo  = sudoAlias;
        sudo  = sudoAlias;
    };
    generalAliases = {
        llo   = "${pkgs.lsd}/bin/lsd --long --permissions octal";   # Show octal permissions
        cat   = "bat -Pp";                                  # Use bat instead of cat
        ip    = "ip --color=auto";                          # Color IP command
        mkdir = "mkdir -pv";                                # Always create directory trees
    };
in {
    programs.zsh.shellAliases = generalAliases // sudoAliases;
    programs.zsh = {
        enable = true;
        autocd = true;
        dotDir = ".config/zsh";
    };
    programs.zsh.envExtra = ''
        ZSH_SELF_LSPWD=true
        WORDCHARS=""
    '';
    programs.zsh.history = {
        path = "${config.xdg.dataHome}/zsh/history";
        size = 50000;
        save = 50000;
        extended = false;
        ignoreSpace = true;
        ignoreDups = true;
        share = true;
    };
    programs.zsh.initExtra = lib.concatMapStrings builtins.readFile [
        ../../../../config/zshrc
    ];
    programs.zsh.plugins = [
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
}