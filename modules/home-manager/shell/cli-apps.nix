{ pkgs, lib, config, ... }: {
    config = lib.mkMerge [
        {
            home.packages = with pkgs; [
                nmap
                sipcalc
                yt-dlp
                ranger
                openssl
                neofetch
                yubikey-manager
            ];
        }
    ];
}