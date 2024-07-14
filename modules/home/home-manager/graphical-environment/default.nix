{ desktop, ... }:
let
  gnome = builtins.hasAttr "gnome" desktop && desktop.gnome;
  plasma = builtins.hasAttr "plasma" desktop && desktop.plasma;
  hyperland = builtins.hasAttr "hyperland" desktop && desktop.hyperland;
  thickpkgs = builtins.hasAttr "thickpkgs" desktop && desktop.thickpkgs;
in
{
    imports = [ 
      ./packages-minimal.nix
    ] ++
      (if (gnome) then [ ./gnome.nix ] else [  ]) ++
      (if (plasma) then [ ./plasma.nix ] else [  ]) ++
      (if (hyperland) then [ ./hyperland.nix ] else [  ]) ++
      (if (thickpkgs) then [ ./packages-thick.nix ] else [  ]);
}