{ pkgs, ...}: {
    programs.bat.enable = true;
    programs.bat.config = {
        theme = "TwoDark";
        map-syntax = [
            ".ignore:Git Ignore"
            ".stignore:Git Ignore"
        ];
    };
    programs.bat.extraPackages = with pkgs.bat-extras; [
        batdiff batman batwatch
    ];
}