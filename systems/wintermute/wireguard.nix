{ config, lib, inputs, ... }: {
    age.secrets.wireguard_key = {
        file = ./secrets/wireguard.age;
        owner = "root";
        group = "root";
    };
    networking.wg-quick.interfaces = {
        wg-home-ra = {
            privateKeyFile = config.age.secrets.wireguard_key.path;
            address = [ "172.22.0.130/25" ];
            postUp = [
                "resolvectl domain wg-home-ra '~zynthovian.xyz'"
                "resolvectl dns wg-home-ra 172.22.0.129"
            ];
            peers = [
                {
                    endpoint = "vpn.zynthovian.xyz:51820";
                    publicKey = "Z5y5mnVxyn6ltOvPTHd1ZmsnlqIEXHT1Y5QOTjNJpiY=";
                    persistentKeepalive = 25;
                    allowedIPs = [ "172.22.0.0/23" "172.21.0.0/24" ];
                }
                
            ];
        };
    };
}