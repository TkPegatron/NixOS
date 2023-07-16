{ inputs, pkgs, config, ... }: {
    imports = [
        # -- {Import all submodules here}-----------------#
        ./shell
        ./direnv
        ./neovim
        ./gpg
        ./git
    ];
    config.modules = {
        # --{ Universally enable submodules}--------------#
        shell.enable = true;
        neovim.enable = true;
    };
    config.home.stateVersion = "23.05";
}