{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gpg;
in {
    options.modules.gpg = { enable = mkEnableOption "gpg"; };
    config = mkIf cfg.enable (lib.mkMerge [
        {
            programs.gpg = {
                enable = true;
                homedir = "${config.xdg.configHome}/gnupg";
            };
            services.gpg-agent = {
                enable = true;
                pinentryFlavor = "qt";
                enableSshSupport = true;
                defaultCacheTtl = 31536000;
                maxCacheTtl = 31536000;
            };
            home.sessionVariables = {
                GNUPGHOME = config.programs.gpg.homedir;
            };
        }
    ]);
}
