{ config, pkgs, lib, inputs, ... }:
with lib;
let cfg = config.modules.gnome;
in {
    options.modules.gnome = { enable = mkEnableOption "gnome"; };
    config = mkIf cfg.enable (lib.mkMerge [
        {
            home.packages = with pkgs; [
                gnomeExtensions.unite
                gnomeExtensions.espresso
                gnomeExtensions.just-perfection
                gnomeExtensions.dash-to-dock
                gnome.gnome-tweaks
            ];
        }
    ]);
}