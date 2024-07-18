_: {
    programs.starship.enable = true;
    xdg.configFile = {
        "starship.toml".text = builtins.readFile ../../../../config/starship-nf.toml;
    };
    programs.zsh.envExtra = ''
        STARSHIP_OS_ICON="*"
    '';
}