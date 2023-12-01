{outputs, inputs, ...}: let
  # Overlay custom packages into nixpkgs
  additions = final: _: import ../pkgs {pkgs = final;};
  # Overlay existing packages
  modifications = final: prev: {
    steam = prev.steam.override {
      extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${inputs.nix-gaming.packages.${prev.system}.proton-ge}'";
    };
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
