{ helpers, lib, ... }: {
  imports = [
    ./audit.nix
    ./console.nix
    ./core.nix
    ./libvirt.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./passwd.nix
    ./podman.nix
    ./security.nix
    ./sshc.nix
    ./sshd.nix
    ./zram.nix
  ];
}
