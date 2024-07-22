{ lib, desktop, ... }: 
let
    graphical = builtins.hasAttr "graphical" desktop && desktop.graphical;
in {
    config = lib.mkMerge [
        {
            programs.starship.enable = true;
            xdg.configFile = {
                "starship.toml".text = (
                    if (graphical)
                    then builtins.readFile ../../../../config/starship/nf-singleline.toml
                    else builtins.readFile ../../../../config/starship/bf-singleline.toml
                    );
            };
        }
    ];
}