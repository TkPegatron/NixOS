{ pkgs, user, config, ... }: 
let 
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
  users.users.root.shell = pkgs.zsh;
  users.users."${user.username}" = {
    isNormalUser = true;
    description = "${user.fullname}";
    openssh.authorizedKeys.keys = [];
    group = "${user.username}";
    extraGroups = extraUserGroups ++ [
      user.username
    ];
    shell = pkgs.zsh;
  };
}