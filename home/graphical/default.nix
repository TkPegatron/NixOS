{ config, pkgs, lib, inputs, ... }:
with lib;
let cfg = config.modules.graphical;
in {
    options.modules.graphical = { enable = mkEnableOption true; };
    config = mkIf cfg.enable (lib.mkMerge [
        {
            home.packages = with pkgs; [ discord ];
        }
        {
            home.packages = with pkgs; [ meld wireshark ];
            # Configuration for VSCode
            home.sessionVariables.NIXOS_OZONE_WL = "1";
            programs.vscode.enable = true;
            programs.vscode.package = with pkgs; pkgs.vscode;
        }
        {
            home.packages = with pkgs; [
                ffmpeg krita gimp inkscape
            ];
        }
        {
            home.packages = with pkgs; [
                # Install Vivaldi with proprietary codecs and decryption
                (vivaldi.override {
                      proprietaryCodecs = true;
                      enableWidevine = true;
                })
            ];
        }
        {
            home.packages = with pkgs; [
                openlens   # Kubernetes IDE
            ];
        }
    ]);
}
