{ inputs, pkgs, config, ... }: {
    imports = [
        # -- {Import all submodules here}-----------------#
        ./development.nix
        ./multimedia.nix
        ./web_browser.nix
    ];
}