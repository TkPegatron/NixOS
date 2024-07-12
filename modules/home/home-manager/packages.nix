{ pkgs, lib, ... }: {
    home.packages = with pkgs; [
        nmap
        sipcalc
        yt-dlp
        ranger
        neofetch
    ];
}