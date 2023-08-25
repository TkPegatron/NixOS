{ config, pkgs, lib, inputs, ... }: {
    config = lib.mkMerge ([
        {
            hardware.pulseaudio.enable = false;
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
        { # Remove or replace gnome's default packages
            environment.gnome.excludePackages = with pkgs.gnome; [
                gnome-initial-setup gnome-music
                gnome-weather simple-scan totem epiphany geary
                yelp tali cheese
            ];
            environment.systemPackages = with pkgs; [
                celluloid # MPV Frontend
                # Havent Decided between these two yet
                qimgv libsForQt5.gwenview
            ];
        }
    ]);
}
