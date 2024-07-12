{ desktop, ... }:
let
  gnome = builtins.hasAttr "gnome" desktop && desktop.gnome;
  plasma = builtins.hasAttr "plasma" desktop && desktop.plasma;
  hyperland = builtins.hasAttr "hyperland" desktop && desktop.hyperland;
in
{
  imports = [
    ./fonts.nix
    ./general.nix
    ./packages.nix
  ] ++
    (if (gnome) then [ ./gnome.nix ] else [  ]) ++
    (if (plasma) then [ ./plasma.nix ] else [  ]) ++
    (if (hyperland) then [ ./hyperland ] else [  ]);
}