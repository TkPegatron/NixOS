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
    #(haskell.lib.justStaticExecutables haskellPackages.hopenpgp-tools)
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
  ];
  services.pcscd.enable = true;
  services.udev.packages = [
    pkgs.yubikey-personalization
  ];
}