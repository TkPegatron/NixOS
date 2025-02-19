{ pkgs, user, config, ... }: 
let
  password = "$y$j9T$zwImDNhx/m6xqpJk4y17s/$61DGJaZbKvtZaplx.d1Zj02fqwKUWoKPOB5fj1yd2y1";
  groupExists = grp: builtins.hasAttr grp config.users.groups;
  groupsIfExist = builtins.filter groupExists;
  extraUserGroups = groupsIfExist [
    "users" "wheel" "audio" "video"
    "input" "plugdev" "dialout"
    "docker" "podman" "libvirtd"
    "wireshark" "networkmanager"
    "power" "nix" "lp"
    "systemd-journal"
    "adbusers"
  ];
in {
  programs.zsh.enable = true;
  users.groups = {
    "${user.username}" = { };
  };
  users.mutableUsers = false;
  users.users.root = {
    shell = pkgs.zsh;
    hashedPassword = password;
  };
  users.users."${user.username}" = {
    isNormalUser = true;
    description = "${user.fullname}";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7DAHfg26u7UylYiF6PiM9hdbe4ejAfmjgq/Lpa0Nb+ cardno:22_730_621"
    ];
    group = "${user.username}";
    hashedPassword = password;
    extraGroups = extraUserGroups ++ [
      user.username
    ];
    shell = pkgs.zsh;
  };
}