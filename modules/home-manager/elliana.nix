{ config, lib, inputs, ...}: {
    imports = [ ./common.nix ];
    config = lib.mkMerge [
        { #--{Modules Configuration}------------------------#
            modules = {};
        }
        { #--{Git User-Specific Config}---------------------#
            programs.git.includes.default.contents = {
                user = {
                    name = "Elliana Perry";
                    email = "elliana.perry@gmail.com";
                };
                commit.gpgSign = true;
            };
        }
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