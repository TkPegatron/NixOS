{ config, pkgs, lib, ... }: {
    config = lib.mkMerge ([
        {
            security.audit.enable = true;
            security.auditd.enable = true;
            #environment.etc."audit/auditd.conf" = {
            #    user = "root";
            #    group = "root";
            #    text = builtins.readFile (pkgs.fetchurl {
            #        url = "https://raw.githubusercontent.com/linux-audit/audit-userspace/master/init.d/auditd.conf";
            #        hash = "sha256-1lnll+po/8o2XJvrlYWAux3v5hILibEhnHrP9+gMFng=";
            #        #lib.fakeHash
            #    });
            #};
            #environment.etc."audit/audit.rules" = {
            #    user = "root";
            #    group = "root";
            #    text = builtins.readFile (pkgs.fetchurl {
            #        url = "https://raw.githubusercontent.com/Neo23x0/auditd/master/audit.rules";
            #        hash = "sha256-uMwSvpB2I/cnjM1DORQxqZbXZXLRLy9YTBJUCn5IptA=";
            #    });
            #};
            systemd.services.auditd = {
                serviceConfig = {
                    ExecStartPost = "-/sbin/auditctl -R /etc/audit/audit.rules";
                };
            };
        }
    ]);
}
