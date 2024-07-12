{ pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        wireguard-tools
        ivpn-service
        ivpn
    ];
}