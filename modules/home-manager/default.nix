{ inputs, pkgs, config, ... }:

{
    imports = [
        # -- {Import all submodules here}-----------------#
        ./shell
        ./neovim
    ];
    config.modules = {
        # --{ Universally enable submodules}--------------#
        shell.enable = true;
        neovim.enable = true;
    };
}