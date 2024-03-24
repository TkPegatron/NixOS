{ config, lib, pkgs, ... }: {
    #! Make sure that this file is not sourced during system installation
    #!  SSHd will probably fail if the file isnt present
    #! Ignore me if we figured out a good way to deploy keys statically
    services.openssh.extraConfig = ''
        # Present signed host certificates
        HostCertificate /etc/ssh/ssh_host_ed25519_key-cert.pub
    '';
}