{ config, lib, pkgs, inputs, ...}: {
    config = lib.mkMerge [
        {
            home.packages = with pkgs; [
                # Install Vivaldi with proprietary codecs and decryption
                (vivaldi.override {
                      proprietaryCodecs = true;
                      enableWidevine = true;
                })
            ];
        }
    ];
}