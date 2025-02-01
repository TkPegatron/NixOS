{ pkgs, lib, ... }: {
    config = (lib.mkMerge [
        {
            hardware.bluetooth.enable = true;
            hardware.bluetooth.powerOnBoot = true;
            hardware.bluetooth.settings = {
                General = {
                    Experimental = true;
                };
            };
        }
    ]);
}