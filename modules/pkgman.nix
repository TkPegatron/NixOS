# Configuration for the nix package manager
{ config, nixpkgs, pkgs, lib, inputs, ... }: {
    config = lib.mkMerge ([
        { #--{Package Management}--------------#
            documentation = {
                enable = true;
                doc.enable = false;
                man.enable = true;
                dev.enable = false;
            };
            nix = {
                extraOptions = ''
                    warn-dirty = false
                    keep-outputs = true
                    keep-derivations = true
                    min-free = ${toString (100 * 1024 * 1024)}
                    max-free = ${toString (1024 * 1024 * 1024)}
                    experimental-features = nix-command flakes recursive-nix
                '';
                gc = {
                    options = "--delete-older-than 3d";
                    automatic = true;
                    dates = "daily";
                };
                optimise = {
                    automatic = true;
                    dates = [ "weekly" ];
                };
                settings = {
                    log-lines = 20;
                    sandbox = true;
                    max-jobs = "auto";
                    auto-optimise-store = true;
                    flake-registry = "/etc/nix/registry.json";
                    # allow sudo users to mark the following values as trusted
                    allowed-users = ["@wheel"];
                    # only allow sudo users to manage the nix store
                    trusted-users = ["@wheel"];
                    # continue building derivations if one fails
                    keep-going = true;
                    extra-experimental-features = [
                        "flakes" "nix-command" "recursive-nix" "ca-derivations"
                    ];
                    # use binary caches
                    builders-use-substitutes = true;
                    # List of caches to use
                    substituters = [
                        #"https://cache.nixos.org"
                        "https://nixpkgs-unfree.cachix.org"
                        "https://nix-community.cachix.org"
                        "https://nixpkgs-wayland.cachix.org"
                        "https://hyprland.cachix.org"
                    ];
                    trusted-public-keys = [
                        #"cache.nixos.org-1:"
                        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
                        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                    ];
                };
                # Add system inputs to legacy channels to keep commands consistent
                nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
                # Pin registry to avoid evaluating a new nixpkgs version every time
                registry = lib.mapAttrs (_: v: {flake = v;}) inputs;
                # Run builds with low priority to preserve system responsiveness
                daemonCPUSchedPolicy = "idle";
                daemonIOSchedClass = "idle";
            };
            environment.defaultPackages = [];
        }
    ]);
}
