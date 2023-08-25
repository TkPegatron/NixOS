{
    description = "NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixos-hardware.url = "github:nixos/nixos-hardware";
        impermanence.url = github:nix-community/impermanence;

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nur = {
            url = "github:nix-community/NUR";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-gaming.url = "github:fufexan/nix-gaming";

        #hyprland = {
        #    url = "github:hyprwm/Hyprland/";
        #    inputs.nixpkgs.follows = "nixpkgs";
        #};

        #hyprcontrib = {
        #    url = "github:hyprwm/contrib";
        #    inputs.nixpkgs.follows = "nixpkgs";
        #};

        #xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";

        rust-overlay = {
          url = "github:oxalica/rust-overlay";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    # All outputs for the system (configs)
    outputs = { home-manager, nixpkgs, nur, agenix, ... }@inputs: 
        let
            system = "x86_64-linux"; #current system
            pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
            lib = nixpkgs.lib;
            mkSystem = pkgs: system: hostname:
                pkgs.lib.nixosSystem {
                    system = system;
                    modules = [
                        { networking.hostName = hostname; }
                        # General configuration (users, networking, sound, etc)
                        ./modules/system/default.nix
                        # Hardware config (bootloader, kernel modules, filesystems, etc)
                        (./. + "/hosts/${hostname}/")
                        # AGE Secrets Encryption
                        agenix.nixosModules.default
                        # Home-Manager
                        home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useUserPackages = true;
                                useGlobalPkgs = true;
                                extraSpecialArgs = { 
                                    inherit inputs;
                                };
                            };
                            nixpkgs.overlays = [
                                # -{ Add nur overlay }
                                nur.overlay
                                #(import ./overlays)
                            ];
                        }
                    ];
                    specialArgs = { inherit inputs; };
                };

        in {
            nixosConfigurations = {
                # -{ System Definitions }
                wintermute = mkSystem inputs.nixpkgs "x86_64-linux" "wintermute";
                legion = mkSystem inputs.nixpkgs "x86_64-linux" "legion";
            };
    };
}
