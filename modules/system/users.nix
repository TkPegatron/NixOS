{config, pkgs, ...}:
with lib;
let
  groupExists = grp: builtins.hasAttr grp config.users.groups;
  groupsIfExist = builtins.filter groupExists;
in
{
  programs.zsh.enable = true;
  users = {
    mutableUsers = false;
    users = {
      root = {
        shell = pkgs.zsh;
        initialHashedPassword =
          "$6$PGLB6RuHp8APuNbK$wijx7Ggs//iS6e79/gITwnCYk4v.pFDrqReqDUa1Ft/nV5eNeY9gMJeewFMY4HNixL5dtTDhQ1aQIYUsEAZlp.";
      };
      elliana = {
        description = "Elliana Perry";
        isNormalUser = true;
        initialHashedPassword = 
          "$6$XbN67zeoi4SK8f7W$Tj5lFhMjNbBSvbBF1.zAgOM0jxqMmMNy/mhhXoNONXW2MZdW1rHReyAk5MTaOZpfEvXx7wes6xyt21/93T5s1.";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1WrsxCqVK8oVf4whQs3W+vAV8ioV4bVr7399SSj4xC"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII+gTodZbPhGkhk3DJDn4MKTURN0pW1jnKKj4QYKJ58j"
        ];
        extraGroups = groupsIfExist [
          "wheel" "audio" "video"
          "input" "plugdev" "dialout"
          "docker" "podman" "libvirtd"
          "wireshark" "networkmanager"
          "power" "nix" "lp"
          "systemd-journal"
        ];
        uid = 1000;
        shell = pkgs.zsh;
      };
    };
  };
  home-manager.users= {
    elliana = ../home-manager/elliana.nix;
    root = ../home-manager/root.nix;
  };
}