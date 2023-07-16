{ config, lib, inputs, ... }: {
  imports = [inputs.impermanence.nixosModule];
  services.openssh.hostKeys = [
    # Override where sshd stores host keys
    {type = "ed25519"; path = "/persist/ssh/ssh_host_ed25519_key";}
    {type = "rsa"; bits = 4096; path = "/persist/ssh/ssh_host_rsa_key";}
  ];
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager" # NetworkManager configuration data
      "/etc/nixos"          # nixos system config files
      "/var/lib"            # system service persistent data
    ];
  };
  # for some reason *this* is what makes networkmanager not get screwed completely instead of the impermanence module
  #systemd.tmpfiles.rules = [
  #  "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
  #  "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
  #  "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  #];
}