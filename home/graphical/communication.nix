{ config, lib, pkgs, nixpkgs, inputs, ...}: {
    config = lib.mkMerge ([
        {
            nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "discord" ];
            home.packages = with pkgs; [ discord ];
        }
    ]);
}
