{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cfssl
    openssl
    cryptsetup
    diceware
    ent
    git
    gitAndTools.git-extras
    gnupg
    gpg-scripts
    paperkey
    parted
    pcsclite
    pcsctools
    pgpdump
    pinentry-curses
    pwgen
    yk-scripts
    yubikey-manager
    yubikey-personalization
    drduh-gpg-guide

    # Yubikey - Openssl engine
    openssl
    opensc
    libp11
    p11-kit
  ];
  services.pcscd.enable = true;
  services.udev.packages = [
    pkgs.yubikey-personalization
  ];
  environment.etc."ssl/openssl.cnf".text = ''
    openssl_conf = openssl_init
    [openssl_init]
      engines=engine_section
    [engine_section]
      pkcs11 = pkcs11_section
    [pkcs11_section]
      engine_id = pkcs11
      dynamic_path = ${pkgs.libp11}/lib/engines/libpkcs11.so
      MODULE_PATH = ${pkgs.opensc}/lib/pkcs11/opensc-pkcs11.so
      init = 0
    '';
}