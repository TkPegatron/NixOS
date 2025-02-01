{ extra, ... }:
let
  vpn = builtins.hasAttr "vpn" extra && extra.vpn;
  wine = builtins.hasAttr "wine" extra && extra.wine;
  yubikey = builtins.hasAttr "yubikey" extra && extra.yubikey;
  tools = builtins.hasAttr "tools" extra && extra.tools;
  bluetooth = builtins.hasAttr "bluetooth" extra && extra.bluetooth;
in
{
  imports = [  ] ++
    (if (vpn) then [ ./vpn.nix ] else [  ]) ++
    (if (wine) then [ ./wine.nix ] else [  ]) ++
    (if (yubikey) then [ ./yubikey.nix ] else [  ]) ++
    (if (tools) then [ ./extra-tools.nix ] else [  ]) ++
    (if (bluetooth) then [ ./bluetooth.nix ] else [  ]);
}