{
  description = "Nixos configuration waayway";

  inputs = {
    # have unstable if needed for some packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = github:nix-community/impermanence;

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }:
    let
      nixosSystem = import ./lib/nixosConfig.nix;
      version = "24.05";
    in
    {
      nixosConfigurations = {
        ephemera = nixosSystem "ephemera" {
          # `nix build .#nixosConfigurations.ephemera.config.system.build.isoImage --show-trace`
          inherit inputs nixpkgs nixpkgs-unstable version;
          system = "x86_64-linux";
          user = "nixos";
          fullname = "NixOS";
          hardware.iso = true;
          desktop.hyperland = true;
          extra.yubikey = true;
        };
        wintermute = nixosSystem "wintermute" {
          inherit inputs nixpkgs nixpkgs-unstable version;
          system = "x86_64-linux";
          user = "elliana";
          fullname = "Elliana Perry";
          hardware.laptop = true;
          extra.yubikey = true;
          desktop = {
            hyperland = true;
            thickpkgs = true;
          };
        };
      };
    };
}