{ config, lib, inputs, ...}: {
    imports = [ ./common.nix ];
    config.modules = {
        gpg.enabled = true;
    };
}