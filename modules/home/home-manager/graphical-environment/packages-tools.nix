{ pkgs, lib, ... }: {
    config = (lib.mkMerge [
        {
            home.packages = with pkgs; [
                wireshark
                responder
                hashcat
            ];
        }
    ]);
}