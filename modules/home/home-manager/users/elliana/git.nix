_: {
    programs.git = {
        enable = true;
        includes = [{
            contents = {
                commit.gpgSign = true;
                user.name = "Elliana Perry";
                user.email = "elliana.perry@gmail.com";
            };
        }];
    };
}