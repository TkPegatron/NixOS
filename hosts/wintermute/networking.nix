{ config, lib, inputs, ... }: {
    age.secrets.wireguard_key = {
        file = ./secrets/wireguard.age;
        owner = "root";
        group = "root";
    };
    networking.firewall = {
        allowedUDPPorts = [ 51820 ];
    };
    networking.wireguard.interfaces = {
        wg-home-ra = {
            ips = [ "172.22.0.130" ];
            listenPort = 51820;
            privateKeyFile = config.age.secrets.wireguard_key.path;
            #peers = [
            #    { # home firewall
            #        publicKey = "{client public key}";
            #        allowedIPs = [ "10.0.0.2/32" ];
            #    }
            #];
        };
    };
}