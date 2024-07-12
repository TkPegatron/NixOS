{ lib, nixpkgs, config, inputs, ... }: {
  nixpkgs.config.allowUnfree = lib.mkForce true;

  nix.extraOptions = ''
    warn-dirty = false
    keep-outputs = true
    keep-derivations = true
    min-free = ${toString (100 * 1024 * 1024)}
    max-free = ${toString (1024 * 1024 * 1024)}
    experimental-features = nix-command flakes recursive-nix
  '';
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };
  nix.settings = {
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
  nix.nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  # Pin registry to avoid evaluating a new nixpkgs version every time
  nix.registry = lib.mapAttrs (_: v: {flake = v;}) inputs;
  # Run builds with low priority to preserve system responsiveness
  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";

  nix.channel.enable = false;
}