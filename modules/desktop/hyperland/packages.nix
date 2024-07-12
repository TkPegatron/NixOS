{ pkgs, pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs; [
    cinnamon.nemo
    wl-clipboard
    kitty
  ];
}