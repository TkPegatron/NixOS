{ config, lib, pkgs, inputs, ...}: {
    config = lib.mkMerge [
        {
            home.packages = with pkgs; [ meld wireshark ];
            programs.vscode.enable = true;
            programs.vscode.package = with pkgs; pkgs.vscode;
        }
    ];
}