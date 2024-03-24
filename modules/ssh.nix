{ config, pkgs, lib, inputs, ... }: {
    config = lib.mkMerge ([
        { #--{SSH Key and Certificate Authority Trust}-----------#
            services.openssh.extraConfig = ''
                # Accept signed user certificates
                TrustedUserCAKeys /etc/ssh/ssh_user_ca-zynthovian-xyz.pub
            '';
            environment.etc = {
                "ssh/ssh_user_ca-zynthovian-xyz.pub" = {
                    text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmth45B8vaVPPJ6Ds4Y/t3tdfuiSmd7SkLwRGcORm3I ssh-user-ca@zynthovian.xyz";
                    mode = "0644";
                };
            };
            programs.ssh.knownHostsFiles = [
                (pkgs.writeText "ssh_known_hosts.zynthovian" ''
                    @cert-authority * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIABy36o1qmUfAyrEdFv7KlDSBdIECIGUviVUNP4y35eT ssh-host-ca@zynthovian.xyz
                '')
                (pkgs.writeText "ssh_known_hosts.github" ''
                    github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
                    github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
                    github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
                '')
            ];
        }
    ]);
}