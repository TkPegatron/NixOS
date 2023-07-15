{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.neovim;
in {
    options.modules.neovim = { enable = mkEnableOption "neovim"; };
    config = mkIf cfg.enable (mkMerge [
        { #--{Neovim Configuration}---------------------#
            home.packages = with pkgs; [ neovim ];
            home.sessionVariables = {
                EDITOR = "nvim";
                VISUAL = "nvim";
            };
        }
    ]);
}