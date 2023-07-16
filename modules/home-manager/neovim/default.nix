{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.neovim;
in {
    options.modules.neovim = { enable = mkEnableOption "neovim"; };
    config = mkIf cfg.enable (lib.mkMerge [
        { #--{Neovim Configuration}---------------------#
            home.packages = with pkgs; [ neovim ];
            home.sessionVariables = {
                EDITOR = "nvim";
                VISUAL = "nvim";
            };
            programs.zsh.shellAliases = { 
                nano = "nvim";
                vim = "nvim";
                vi = "nvim";
            };
        }
    ]);
}