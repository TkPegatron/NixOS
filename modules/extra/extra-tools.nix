{ pkgs, lib, ... }: {
    config = (lib.mkMerge [
        {
            # Modules
            programs.wireshark.eneable = true;
            
            # Packages
            home.packages = with pkgs; [
                responder
                hashcat
                ndisc6
            ];
        }
    ]);
}