{ config, pkgs, lib, inputs, ... }: {
    config = lib.mkMerge ([
        { #--{Network Configuration}-----------#
            security.pki.certificates = [
                ''
                Elliana Perry
                ==============
                -----BEGIN CERTIFICATE-----
                MIIB4DCCAWYCFFY6UiHBqKEcpxxxo4e/+86dtwxWMAoGCCqGSM49BAMCMFQxCzAJ
                BgNVBAYTAlVTMQ0wCwYDVQQIDARPaGlvMQ8wDQYDVQQHDAZNYXVtZWUxJTAjBgNV
                BAMMHEVsbGlhbmEgUGVycnkgQ2VydCBBdXRob3JpdHkwHhcNMjMxMTIyMjIwNzUz
                WhcNNDMxMTI0MjIwNzUzWjBUMQswCQYDVQQGEwJVUzENMAsGA1UECAwET2hpbzEP
                MA0GA1UEBwwGTWF1bWVlMSUwIwYDVQQDDBxFbGxpYW5hIFBlcnJ5IENlcnQgQXV0
                aG9yaXR5MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAELHgnHqKNZs6J7isa26l6BtUE
                Ov9GCb0VKZel+NttlHRAHXj9RdaVZAu1WROun5PBtyq8hik402PG7BGWqTJcvCsp
                zzB2sW2mmUfvg/X2b3gKof9huigSA5x14VzNf4LSMAoGCCqGSM49BAMCA2gAMGUC
                MDh2NRy+vdps1JwsowN5odNautrNCHzlSOWJVFjXHl7bQJgPtCa7zThwNzYLakfx
                lAIxANW89E7najBVzQ3GRwHvJYHE5QlYIgtVv6kFjEZErnPikShQt5HUm3B19puQ
                XKNuXw==
                -----END CERTIFICATE-----
                ''
            ];
            #? Consider switching to networkd
            networking = {
                firewall.enable = true;
                nftables.enable = true;
                networkmanager.enable =true;
                nameservers = [
                    "1.1.1.1" "1.0.0.1"
                    "2606:4700:4700::1111"
                    "2606:4700:4700::1001"
                ];
            };
            # Start NetworkManager during boot but Avoid waiting for a lease
            #systemd.services.NetworkManager-wait-online.enable = false;
            systemd.services.NetworkManager.enable = true;
            boot.kernelModules = [ "tcp_bbr" ];
            boot.kernel.sysctl = {
                # Prevent bogus ICMP errors from filling up logs.
                "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
                # Reverse path filtering causes the kernel to do source validation of
                # packets received from all interfaces. This can mitigate IP spoofing.
                "net.ipv4.conf.default.rp_filter" = 1;
                "net.ipv4.conf.all.rp_filter" = 1;
                # Do not accept IP source route packets (we're not a router)
                "net.ipv4.conf.all.accept_source_route" = 0;
                "net.ipv6.conf.all.accept_source_route" = 0;
                # Don't send ICMP redirects (again, we're on a router)
                "net.ipv4.conf.all.send_redirects" = 0;
                "net.ipv4.conf.default.send_redirects" = 0;
                # Refuse ICMP redirects (MITM mitigations)
                "net.ipv4.conf.all.accept_redirects" = 0;
                "net.ipv4.conf.default.accept_redirects" = 0;
                "net.ipv4.conf.all.secure_redirects" = 0;
                "net.ipv4.conf.default.secure_redirects" = 0;
                "net.ipv6.conf.all.accept_redirects" = 0;
                "net.ipv6.conf.default.accept_redirects" = 0;
                # Protects against SYN flood attacks
                "net.ipv4.tcp_syncookies" = 1;
                # Incomplete protection again TIME-WAIT assassination
                "net.ipv4.tcp_rfc1337" = 1;
                # Enable TCP fastopen
                "net.ipv4.tcp_fastopen" = 3;
                # Queueing discipline and congestion control
                # Bufferbloat mitigations + slight improvement in throughput & latency
                "net.core.default_qdisc" = "cake";
                "net.ipv4.tcp_congestion_control" = "bbr";
            };
        }
    ]);
}
