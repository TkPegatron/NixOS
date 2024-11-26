{ pkgs, lib, ... }: {
    config = (lib.mkMerge [
        {
            # Modules
            programs.wireshark.enable = true;
            
            # Packages
            environment.systemPackages = with pkgs; [
                responder
                hashcat
                ndisc6
            ];
        }
    ]);
}