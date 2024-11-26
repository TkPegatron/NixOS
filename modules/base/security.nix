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
    MIIC9zCCAn6gAwIBAgIUP+m/ni51/ZkzdW8Y3GPJulrT/2kwCgYIKoZIzj0EAwMw
    eTEmMCQGA1UECgwdWnludGhvdmlhbiBJbnRlcnN0ZWxsYXIgVW5pb24xKDAmBgNV
    BAsMH0RpZ2l0YWwgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZXMxJTAjBgNVBAMMHFJv
    b3QgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMjQwOTE2MDAwMDAwWhcNMzQw
    OTE4MDAwMDAwWjB5MSYwJAYDVQQKDB1aeW50aG92aWFuIEludGVyc3RlbGxhciBV
    bmlvbjEoMCYGA1UECwwfRGlnaXRhbCBJbmZyYXN0cnVjdHVyZSBTZXJ2aWNlczEl
    MCMGA1UEAwwcUm9vdCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTB2MBAGByqGSM49
    AgEGBSuBBAAiA2IABNiyroVO4PiMV8iQBv2ER0Qb/RdsX5k3OmAtaH4pIhyLcXHe
    8MdzYdMmnKJKHCBH24cXUQPX1Hm8uq1afxt3yYIVJyzcXXef/3xz2Y0uSpXZrBoJ
    mNqbtCtD8pAL2Oq5G6OBxjCBwzAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUw
    AwEB/zAdBgNVHQ4EFgQU8ywVEcGb+Wz3akgNXLymh9gu474wHwYDVR0jBBgwFoAU
    8ywVEcGb+Wz3akgNXLymh9gu474wNAYHKwYBBAF6AQQpDCdFbGxpYW5hIFBlcnJ5
    IDxlbGxpYW5hLnBlcnJ5QGdtYWlsLmNvbT4wKgYHKwYBBAF6AgQfDB1Ib21lbGFi
    IENlcnRpZmljYXRlIEF1dGhvcml0eTAKBggqhkjOPQQDAwNnADBkAjA7ajmZIkDL
    lpWWCbeYajQax59Xuv96kqVLKEHGtBmX9C9t0SJdXTiYQgFrwWvI+7YCMAc4mku6
    YHUmHnwIv1aE1uDJgENEg+0JPHYzuV+dSn0RIEmoq8FvNmlf1Cqs1wzlZA==
    -----END CERTIFICATE-----
    ''
  ];
}