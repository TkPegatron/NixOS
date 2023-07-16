{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gpg;
in {
    options.modules.gpg = { enable = mkEnableOption "gpg"; };
    config = mkIf cfg.enable (lib.mkMerge [
        {
            programs.gpg = {
                enable = true;
                homedir = "${config.xdg.configHome}/gnupg";
                settings = {
                    "default-recipient-self" = true;
                    #default-key XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                    # Use UTF-8 character encoding everywhere.
                    "display-charset utf-8" = true;
                    "utf8-strings" = true;
                    # Use GnuPG Agent (gpg-agent) for secret key management.
                    "use-agent" = true;
                    # Don't leak comments or software version information.
                    "no-comments" = true;
                    "no-emit-version" = true;
                    # Display full fingerprints.
                    "keyid-format" = "long";
                    "with-fingerprint" = true;
                    # When verifying a signature made from a subkey, require that the
                    # cross-certification "back signature" on the subkey is present and valid.
                    "require-cross-certification" = true;
                    # Prefer the strongest ciphers and digests in the OpenPGP specification.
                    # To list available algorithms: gpg --version
                    "personal-cipher-preferences" = "AES256 AES192 AES";
                    "personal-digest-preferences" = "SHA512 SHA384 SHA256 SHA224";
                    "personal-compress-preferences" = "BZIP2 ZLIB ZIP Uncompressed";
                    # Use the strongest digest when signing a key.
                    "cert-digest-algo" = "SHA512";
                    "default-preference-list" = "AES256 AES192 AES SHA512 SHA384 SHA256 SHA224 BZIP2 ZLIB ZIP Uncompressed";
                };
            };
            services.gpg-agent = {
                enable = true;
                enableSshSupport = true;
                enableExtraSocket = true;
                enableScDaemon = true;
                maxCacheTtl = 31536000;
                maxCacheTtlSsh = ${config.services.gpg-agent.maxCacheTtl};
                defaultCacheTtl = ${config.services.gpg-agent.maxCacheTtl};
                defaultCacheTtlSsh = ${config.services.gpg-agent.maxCacheTtl};
            };
            home.sessionVariables = {
                GNUPGHOME = config.programs.gpg.homedir;
            };
        }
    ]);
}
