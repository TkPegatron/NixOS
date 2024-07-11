{config, pkgs, ...}: {
    config = {
        users.mutableUsers = false;
        users.users.root = {
            shell = pkgs.zsh;
            initialHashedPassword = "$6$07pSAiuhrIo/eUrG$lPg.obuFm7Ewt0k6NP3iDU4Himtu99UAMZ62jbaupTMixrF8zNPY6e15TE9yOJoI1jCpjanW/muDkaXcMYAL0.";
            hashedPassword = config.users.users."root".initialHashedPassword;
        };
    };
}