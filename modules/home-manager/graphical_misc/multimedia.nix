{ config, lib, pkgs, inputs, ...}: {
    config = lib.mkMerge [
        {
            home.packages = with pkgs; [
                ffmpeg krita gimp inkscape
            ];
        }
    ];
}