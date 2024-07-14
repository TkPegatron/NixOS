{ pkgs, ... }: {
    home.packages = with pkgs; [
        # Zsh Dependencies
        skim fd perl bottom
        # Shell Applications
        nmap sipcalc yt-dlp ranger
        openssl neofetch ffmpeg
    ];
}