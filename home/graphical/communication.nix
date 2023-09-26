{ config, lib, pkgs, nixpkgs, inputs, ...}: {
    config = lib.mkMerge ([
        {
            home.packages = with pkgs; [ discord ];
        }
    ]);
}
