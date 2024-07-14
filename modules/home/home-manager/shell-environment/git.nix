_: {
    programs.git = {
        enable = true;
        extraConfig = {
            init.defaultBranch = "main";
            safe.directory = "/etc/nixos";
            core.excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
        };
    };
}