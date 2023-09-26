{ self, inputs, agenix,
  home-manager, nixpkgs,
  pkgs, nur, system,
  stateVersion, ... }:
rec {
  homeConfig = userName:
    { ... }: {
      imports = [ ( ../home + "/${userName}.nix" ) ];
    };

  mkSystem = 
  {
    hostname,
    systemConfig ? (../systems + "/${hostname}/default.nix"),
    extraModules ? [ ]
  }: nixpkgs.lib.nixosSystem {
    inherit system pkgs;
    specialArgs = { inherit inputs; };
    modules = [
      # -{ General System Config  }
      systemConfig
      ../modules/general_system.nix
      { networking.hostName = hostname; }
      # -{ Include AGE Encryption }
      agenix.nixosModules.default
      # -{ Include Home-Manager   }
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs self stateVersion pkgs; };
        home-manager.users.elliana = homeConfig "elliana" { inherit inputs system pkgs self; };
        home-manager.users.root = homeConfig "root" { inherit inputs system pkgs self; };
      }
      # -{ Include NUR Overlay    }
      {
        nixpkgs.overlays = [ nur.overlay ];
      }
    ] ++ extraModules;
  };
}
