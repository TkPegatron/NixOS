{ inputs, outputs, ... }:
rec {
  homeConfig = userName:
    { ... }: {
      imports = [ ( ../home + "/${userName}.nix" ) ];
    };

  mkSystem = 
  {
    hostname,
    system ? "x86_64-linux",
    systemConfig ? (../systems + "/${hostname}/default.nix"),
    extraModules ? [ ]
  }: inputs.nixpkgs.lib.nixosSystem {
    system = system;
    #inherit system pkgs;
    specialArgs = { inherit inputs outputs; };
    modules = [
      # -{ General System Config  }
      systemConfig
      ../modules/general_system.nix
      { networking.hostName = hostname; }
      # -{ Include AGE Encryption }
      inputs.agenix.nixosModules.default
      # -{ Include Home-Manager   }
      inputs.home-manager.nixosModules.home-manager
      {
        nixpkgs = {
          overlays = [
            outputs.overlays.default
          ];
          config = {
            allowUnfree = true;
          };
        };
      }
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs outputs; };
          users = {
            elliana = homeConfig "elliana" { inherit inputs outputs; };
            root = homeConfig "root" { inherit inputs outputs; };
          };
        };
      }
    ] ++ extraModules;
  };
}
