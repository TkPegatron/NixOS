{ config, pkgs, lib, inputs, ... }:
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
          "$6$07pSAiuhrIo/eUrG$lPg.obuFm7Ewt0k6NP3iDU4Himtu99UAMZ62jbaupTMixrF8zNPY6e15TE9yOJoI1jCpjanW/muDkaXcMYAL0.";
        hashedPassword = config.users.users."root".initialHashedPassword;
      };
      elliana = {
        description = "Elliana Perry";
        isNormalUser = true;
        initialHashedPassword = 
          "$6$Zby1R5nVdcA/3L2A$OY4SUiTiQreKuXtgx8SqAiVgaSTlV7g/Pd4ANYDF9pInsBwyurU6DxzGSUM0/COkUkhMEz3M2lAoUAaDnhcyQ.";
        hashedPassword = config.users.users."elliana".initialHashedPassword;
        openssh.authorizedKeys.keys = [
          # Ideally these could be retreived from a git server
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8u8SQls2xm80xrDKGufi9mfrngmjLiapsRnMh1QITi"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIYbWTYTT64VUBOABSKuCBN5H1mE/NgTT0K1Xjzszbn"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKRwLHJDFwHodUByK0hO0B3ofWGE9fWp13RhFZAu9xc"
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