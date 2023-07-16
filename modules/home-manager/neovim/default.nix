{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.neovim;
in {
    options.modules.neovim = { enable = mkEnableOption "neovim"; };
    config = mkIf cfg.enable (lib.mkMerge [
        { #--{Neovim Configuration}---------------------#
            home.packages = with pkgs; [ neovim ];
            home.sessionVariables = {
                EDITOR = "${pkgs.neovim}/bin/nvim";
                VISUAL = "${pkgs.neovim}/bin/nvim";
            };
            programs.zsh.shellAliases = { 
                nano = "${pkgs.neovim}/bin/nvim";
                vim = "${pkgs.neovim}/bin/nvim";
                vi = "${pkgs.neovim}/bin/nvim";
            };
            programs.git.includes.neovim = {
                core.editor = "${pkgs.neovim}/bin/nvim";
            };
        }
    ]);
}