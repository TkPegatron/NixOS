{ config, lib, inputs, ... }: {
  imports = [inputs.impermanence.nixosModule];
  services.openssh.hostKeys = [
    # Store sshd hostkeys within persist
    {type = "ed25519"; path = "/persist/ssh/ssh_host_ed25519_key";}
    {type = "rsa"; bits = 4096; path = "/persist/ssh/ssh_host_rsa_key";}
  ];
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager" # NetworkManager configuration data
      "/etc/nixos"          # nixos system config files
      "/var/lib"            # system service data
      #"/var/log"            # system logging data, currently its own btrfs subvol
    ];
    files = [
      "/etc/machine-id" # systmed uses this to identify the machine in logs
    ];
  };
  # for some reason *this* is what makes networkmanager not get screwed completely instead of the impermanence module
  #systemd.tmpfiles.rules = [
  #  "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
  #  "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
  #  "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  #];
}