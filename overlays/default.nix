{ inputs, pkgs, ... }: [
  (_: prev: {
    steam = prev.steam.override {
      extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${inputs.nix-gaming.packages.${pkgs.system}.proton-ge}'";
    };
  })
]