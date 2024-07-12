_: {
  security.protectKernelImage = true;
  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };
  security.auditd.enable = true;
  security.audit.enable = true;
  systemd.services.auditd = {
    serviceConfig = {
      ExecStartPost = "-/sbin/auditctl -R /etc/audit/audit.rules";
    };
  };
  security.pki.certificates = [
    ''
    Home Laboratory
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
}