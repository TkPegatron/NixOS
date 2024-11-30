{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" "OpenDyslexic" "Noto"]; })
    openmoji-color
    noto-fonts
  ];
  fonts.fontconfig = {
    enable = true;
    hinting.autohint = true;
    defaultFonts = {
        monospace = ["CaskaydiaCove Nerd Font Mono" "OpenDyslexicM Nerd Font Mono"];
        emoji = [ "OpenMoji Color,OpenMoji" ];
    };
  };
}