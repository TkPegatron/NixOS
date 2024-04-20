{ config, ... }: rec {
  services.syncthing = {
    enable = true;
    user = "elliana";
    dataDir = "/home/elliana/";
    configDir = "/home/elliana/.config/syncthing";
    #extraFlags = [ "--reset-deltas" ];
    #overrideDevices = true;
    #overrideFolders = true;
    settings = {
      devices = {
        "Kubernetes" = { 
          introducer = true;
          addresses = [
            "quic://172.21.0.2:22000"
            "dynamic"
          ];
        };
      };
      folders = {
        "Documents" = {
          path = "/home/elliana/Documents";
          devices = [ "Kubernetes" ];
        };
        "Code" = {
          path = "/home/elliana/Code";
          devices = [ "Kubernetes" ];
        };
        "Sync" = {
          path = "/home/elliana/Sync";
          devices = [ "Kubernetes" ];
        };
      };
    };
  };
}
