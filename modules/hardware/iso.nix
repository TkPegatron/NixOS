{ inputs, lib, hostname, ...}: {
  imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix" ];
  isoImage.isoBaseName = lib.mkForce hostname;
  services.openssh.settings.PermitRootLogin = lib.mkForce "yes";
}