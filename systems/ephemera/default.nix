{ config, lib, inputs, pkgs, ... }: {
    isoImage.isoBaseName = lib.mkForce "nixos-yubikey";
    boot.kernelParams = [ "copytoram" ];
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
    ];
    services.udev.packages = [
        pkgs.yubikey-personalization
    ];
    services.pcscd.enable = true;
    boot.initrd.network.enable = false;
    networking.dhcpcd.enable = false;
    networking.dhcpcd.allowInterfaces = [];
    networking.firewall.enable = true;
    networking.useDHCP = false;
    networking.useNetworkd = false;
    networking.wireless.enable = false;
    boot.cleanTmpDir = true;
    boot.kernel.sysctl = {
        "kernel.unprivileged_bpf_disabled" = 1;
    };

    users.users.root.initialHashedPassword = lib.mkForce "";
    services.openssh.settings.PermitRootLogin = lib.mkForce "no";

    #environment.interactiveShellInit = ''
    #    unset HISTFILE
    #    export GNUPGHOME=/run/user/$(id -u)/gnupg
    #    [ -d $GNUPGHOME ] || install -m 0700 -d $GNUPGHOME
    #    cp ${drduh-gpg-conf}/gpg.conf $GNUPGHOME/gpg.conf
    #    cp ${gpg-agent-conf}  $GNUPGHOME/gpg-agent.conf
    #    echo "\$GNUPGHOME is $GNUPGHOME"
    #'';
}