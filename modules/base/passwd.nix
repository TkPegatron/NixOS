{ pkgs, user, config, ... }: 
let
  password = "$y$j9T$0vxB1n.DyUAiJp8xX.O2P.$MCF4I5.cwUiDCgVLSmuSLqNWHgiMYq2wjgvaClD8xW/";
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
    openssh.authorizedKeys.keys = [];
    group = "${user.username}";
    hashedPassword = password;
    extraGroups = extraUserGroups ++ [
      user.username
    ];
    shell = pkgs.zsh;
  };
}