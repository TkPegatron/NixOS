{ config, lib, inputs, ...}: {
    config = lib.mkMerge [
        {
            home.packages = with pkgs; [
                ffmpeg krita gimp inkscape
            ];
        }
    ];
}