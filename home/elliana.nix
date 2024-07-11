{ config, pkgs, lib, inputs, ...}: {
    imports = [ ./common.nix ];
    config = lib.mkMerge [
        { #--{Modules Configuration}------------------------#
            modules = {
                gnome.enable = true;
                plasma.enable = false;
            };
        }
        { #--{Git User-Specific Config}---------------------#
            programs.git.includes = [{
                contents = {
                    commit.gpgSign = true;
                    user = {
                        name = "Elliana Perry";
                        email = "elliana.perry@gmail.com";
                    };
                };
            }];
        }
        #{ #--{ S3FS Userspace Mounts }----------------------#
        #    systemd.user.services = {
        #        netmount-music = {
        #            Unit = {
        #                Description = "Music Folder";
        #                Wants = "network-online.target";
        #                After = "network-online.target";
        #            };
        #            Service = {
        #                Type = "oneshot";
        #                RemainAfterExit = "yes";
        #                ExecStart = "${pkgs.sshfs}/bin/sshfs xenia.zynthovian.xyz:/srv/media/Media/Music /home/elliana/Music";
        #                ExecStop = "fusermount -u /home/elliana/Music";
        #            };
        #            Install = {
        #                WantedBy = [ "graphical-session.target" ];
        #            };
        #        };
        #    };
        #}
        { #--{GPG User-Specific Config}---------------------#
            modules.gpg.enable = true;
            programs.gpg.publicKeys = [
                {
                    trust = "ultimate";
                    text = builtins.readFile ./gpg/elliana.pub;
                }
            ];
            services.gpg-agent.sshKeys = [
                "ED2EDC2C8563ABB9404C5877DB56182523676CD1"
                "420F1135CC6DA2519C39DFB6C2A05B70B83FE16F"
            ];
        }
    ];
}
