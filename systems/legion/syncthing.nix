{ config, ... }: rec {
  services.syncthing = {
    enable = true;
    user = "elliana";
    dataDir = "/home/elliana/";
    configDir = "/home/elliana/.config/syncthing";
    #extraFlags = [ "--reset-deltas" ];
    #overrideDevices = true;
    #overrideFolders = true;
    devices = {
      "KubernetesKluster" = { 
        introducer = true;
        id = "DONT-PUT-THIS-IN-GIT";
      };
    };
    folders = {
      "Documents" = {
        path = "/home/elliana/Documents";
        devices = [ "KubernetesKluster" ];
      };
      "Code" = {
        path = "/home/elliana/Code";
        devices = [ "KubernetesKluster" ];
      };
      "Sync" = {
        path = "/home/elliana/Sync";
        devices = [ "KubernetesKluster" ];
      };
    };
  };
}
