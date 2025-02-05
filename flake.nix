{
  description = "Nixos configuration waayway";

  inputs = {
    # have unstable if needed for some packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = github:nix-community/impermanence;
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixos-hardware, ... }:
    let
      nixosSystem = import ./lib/nixosConfig.nix;
      version = "24.05";
    in
    {
      nixosConfigurations = {
        #
        # Hardware Installations
        #
        wintermute = nixosSystem "wintermute" {
          # sudo nixos-install --root /mnt --flake .#wintermute
          inherit inputs nixpkgs nixpkgs-unstable version;
          system = "x86_64-linux";
          user = "elliana";
          fullname = "Elliana Perry";
          hardware.laptop = true;
          extra.yubikey = true;
          extra.tools = true;
          desktop = {
            gnome = true;
            thickpkgs = true;
          };
        };
        legion = nixosSystem "legion" {
          # sudo nixos-install --root /mnt --flake .#legion
          inherit inputs nixpkgs nixpkgs-unstable version;
          system = "x86_64-linux";
          user = "elliana";
          fullname = "Elliana Perry";
          hardware = {
            desktop = true;
            hypervisor = true;
            amdgpu = true;
          };
          extra = {
            yubikey = true;
            tools = true;
            bluetooth = true;
          };
          desktop = {
            plasma = true;
            thickpkgs = true;
          };
        };
        htpc = nixosSystem "htpc" {
          # sudo nixos-install --root /mnt --flake .#htpc
          inherit inputs nixpkgs nixpkgs-unstable version;
          system = "aarch64-linux";
          user = "elliana";
          fullname = "Elliana Perry";
          desktop.gnome = true;
        };
        #
        #  ISO images
        #
        ephemera = nixosSystem "ephemera" {
          # `nix build .#nixosConfigurations.ephemera.config.system.build.isoImage --show-trace`
          inherit inputs nixpkgs nixpkgs-unstable version;
          system = "x86_64-linux";
          user = "nixos";
          fullname = "NixOS";
          hardware.iso = true;
          hardware.guest = true;
          desktop.hyperland = true;
          extra.yubikey = true;
        };
        toolbox = nixosSystem "toolbox-nix" {
          # `nix build .#nixosConfigurations.toolbox.config.system.build.isoImage --show-trace`
          inherit inputs nixpkgs nixpkgs-unstable version;
          system = "x86_64-linux";
          user = "toolbox";
          fullname = "NixOS";
          hardware.iso = true;
          desktop.hyperland = true;
          extra.yubikey = true;
        };
      };
    };
}
