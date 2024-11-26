_: {
    programs.gpg.publicKeys = [
        {
            trust = "ultimate";
            text = builtins.readFile ../../../../../config/elliana.pub;
        }
        {
            trust = "ultimate";
            text = builtins.readFile ../../../../../config/11A37ED357D49372-2024-07-25.pub.asc;
        }
    ];
    services.gpg-agent.sshKeys = [
        "6266C7D74348C35047F78F4B24C6C5D909DCE0E4"
    ];
}