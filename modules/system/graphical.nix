{ config, pkgs, lib, inputs, ... }: {
    config = lib.mkMerge ([
        {
            services.pipewire = {
                enable = true;
                # Compatibility shims
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
                jack.enable = true;
            };
            services.xserver = {
                enable = true;
                desktopManager.gnome.enable = true;
                displayManager = {
                    gdm.enable = true;
                    gdm.wayland = true;
                    autoLogin.enable = true;
                    autoLogin.user = "elliana";
                };
                # Enable touchpad support.
                libinput.enable = true;
                libinput.touchpad = {
                    clickMethod = "clickfinger";
                    disableWhileTyping = true;
                };
            };
        }
    ]);
}