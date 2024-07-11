{ inputs, pkgs, config, ... }: {
    imports = [
        # -- {Import all submodules here}-----------------#
        ./graphical
        ./gnome
        ./plasma
        ./shell
        ./neovim
        ./gpg
        ./git
    ];
    config.modules = {
        # --{ Universally enable submodules}--------------#
        shell.enable = true;
        neovim.enable = true;
        git.enable = true;
    };
    config.home.stateVersion = "23.05";
}
