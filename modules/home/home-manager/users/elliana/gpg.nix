_: {
    programs.gpg.publicKeys = [
        {
            trust = "ultimate";
            text = builtins.readFile ../../../../../config/elliana.pub;
        }
    ];
    services.gpg-agent.sshKeys = [
        "ED2EDC2C8563ABB9404C5877DB56182523676CD1"
        "420F1135CC6DA2519C39DFB6C2A05B70B83FE16F"
    ];
}