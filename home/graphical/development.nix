{ config, lib, pkgs, inputs, ...}: {
    config = lib.mkMerge [
        {
            home.packages = with pkgs; [ meld wireshark ];
            
	    # Configuration for VSCode
	    home.sessionVariables.NIXOS_OZONE_WL = "1";
	    programs.vscode.enable = true;
            programs.vscode.package = with pkgs; pkgs.vscode;
        }
    ];
}
