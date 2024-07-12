name: { nixpkgs, nixpkgs-unstable, inputs, system, user, fullname, version, hardware ? {}, desktop ? {}, extra ? {}}:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ (import ../pkgs) ];
  };
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
  };
in
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit inputs version pkgs pkgs-unstable hardware desktop extra;
    hostname = name;
    user = {
      username = user;
      fullname = fullname;
    };
  };
  modules = [
    ../systems/${name}/default.nix
    ../modules/base
    ../modules/desktop
    ../modules/extra
    ../modules/hardware
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    {
      system.stateVersion = version;
    }
  ];
}