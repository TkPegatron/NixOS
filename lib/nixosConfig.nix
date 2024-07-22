name: { 
  nixpkgs, nixpkgs-unstable, inputs, system,
  user, fullname, version,
  extraModules ? [],
  hardware ? {},
  desktop ? {},
  extra ? {}
}: let
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ (import ../pkgs) ];
    config.allowUnfree = true;
  };
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit inputs version pkgs pkgs-unstable hardware extra;
    hostname = name;
    user = {
      username = user;
      fullname = fullname;
    };
    desktop = desktop // {
      graphical = (
        builtins.hasAttr "gnome" desktop && desktop.gnome
        || builtins.hasAttr "plasma" desktop && desktop.plasma
        || builtins.hasAttr "hyperland" desktop && desktop.hyperland
      );
    };
  };
  modules = [
    ../systems/${name}/default.nix
    ../modules/base
    ../modules/desktop
    ../modules/extra
    ../modules/hardware
    ../modules/home
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    {
      system.stateVersion = version;
    }
  ] ++ extraModules;
}