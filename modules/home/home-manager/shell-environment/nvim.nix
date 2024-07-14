{ pkgs, ... }: {
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
    programs.git.includes = [{ 
        contents.core.editor = "${pkgs.neovim}/bin/nvim";
    }];
}