{
  description = "Elliana's NixOS Configurations";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nur, agenix, ... }@inputs:
  let
    system = "x86_64-linux";
    stateVersion = "23.05";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    utils = import ./lib {
      inherit inputs self home-manager
              nixpkgs system pkgs nur
              agenix stateVersion;
    };
  in
  {
    nixosConfigurations = {
      wintermute = utils.mkSystem {
        hostname = "wintermute";
        extraModules = [
          ./modules/extra/gnome.nix
          ./modules/extra/virtualization.nix
        ];
      };
      legion = utils.mkSystem {
        hostname = "legion";
        extraModules = [
          ./modules/extra/gnome.nix
          ./modules/extra/gaming.nix
          ./modules/extra/virtualization.nix
        ];
      };
    };
  };
}
