{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ virt-manager podman-compose ];
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
  };
}
