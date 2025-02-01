{ pkgs, lib, ... }: {
    config = (lib.mkMerge [
        {
            hardware.bluetooth.enable = true;
            hardware.bluetooth.powerOnBoot = true;
            hardware.bluetooth.package = pkgs.bluez;
            hardware.bluetooth.settings = {
                General = {
                    Experimental = true;
                };
            };
        }
    ]);
}