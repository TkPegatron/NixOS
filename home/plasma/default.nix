{ config, pkgs, lib, inputs, ... }:
with lib;
let cfg = config.modules.plasma;
in {
    options.modules.plasma = { enable = mkEnableOption "plasma"; };
    config = mkIf cfg.enable (lib.mkMerge [
        {
            services.gpg-agent.pinentryPackage = pkgs.pinentry-qt;
        }
    ]);
}
