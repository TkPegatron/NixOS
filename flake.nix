{
  description = "Elliana's NixOS Configurations";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    impermanence.url = github:nix-community/impermanence;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nur, agenix, ... }@inputs:
  let
    inherit (self) outputs;
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux"];
    forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
    myLib = import ./lib {inherit inputs outputs;};
  in {
    overlays = import ./overlays {inherit inputs outputs;};
    packages = forEachPkgs (pkgs: import ./pkgs {inherit pkgs;});
    
    nixosConfigurations = {
      wintermute = myLib.mkSystem {
        hostname = "wintermute";
        system = "x86_64-linux";
        extraModules = [
          ./modules/extra/gnome.nix
          ./modules/extra/virtualization.nix
        ];
      };
      legion = myLib.mkSystem {
        hostname = "legion";
        system = "x86_64-linux";
        extraModules = [
          ./modules/extra/wine.nix
          ./modules/extra/gnome.nix
          ./modules/extra/gaming.nix
          ./modules/extra/virtualization.nix
        ];
      };
      ephemera = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./systems/ephemera
          ./modules/common.nix
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs outputs; };
              users = {
                nixos = myLib.homeConfig "nixos" { inherit inputs outputs; };
                root = myLib.homeConfig "root" { inherit inputs outputs; };
              };
            };
          }
          {
            home-manager.users.nixos.config.modules.gnome.enable = nixpkgs.lib.mkForce false;
          }
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
        ];
      };
    };
  };
}
