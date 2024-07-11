{config, pkgs, ...}: {
    config = let
        groupExists = grp: builtins.hasAttr grp config.users.groups;
        groupsIfExist = builtins.filter groupExists;
        extraUserGroups = groupsIfExist [
          "wheel" "audio" "video"
          "input" "plugdev" "dialout"
          "docker" "podman" "libvirtd"
          "wireshark" "networkmanager"
          "power" "nix" "lp"
          "systemd-journal"
        ];
    in {
        users.mutableUsers = false;
        users.groups.elliana = {};
        users.users.elliana = {
            uid = 1000;
            shell = pkgs.zsh;
            isNormalUser = true;
            description = "Elliana Perry";
            group = "elliana";
            extraGroups = extraUserGroups;
            initialHashedPassword = 
              "$6$Zby1R5nVdcA/3L2A$OY4SUiTiQreKuXtgx8SqAiVgaSTlV7g/Pd4ANYDF9pInsBwyurU6DxzGSUM0/COkUkhMEz3M2lAoUAaDnhcyQ.";
            hashedPassword = config.users.users."elliana".initialHashedPassword;
            openssh.authorizedKeys.keys = [
              # Ideally these could be retreived from a git server
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8u8SQls2xm80xrDKGufi9mfrngmjLiapsRnMh1QITi"
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIYbWTYTT64VUBOABSKuCBN5H1mE/NgTT0K1Xjzszbn"
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKRwLHJDFwHodUByK0hO0B3ofWGE9fWp13RhFZAu9xc"
            ];
        };
    };
}