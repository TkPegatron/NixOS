{ pkgs, ... }: {
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
  environment.systemPackages = with pkgs; [
    #(uutils-coreutils.override { prefix = ""; })
    nix-prefetch

    neovim

    strace
    ltrace
    bpftrace
    tcpdump
    lsof

    sysstat
    iotop
    iftop
    btop
    nmon
    sysbench

    psmisc
    lm_sensors
    ethtool
    pciutils
    usbutils
    hdparm
    dmidecode
    parted

    doggo
    dig
    mtr

    restic
    rsync

    s3fs
    sshfs

    pinentry
    openssl
  ];

  environment.variables.EDITOR = "nvim";
}