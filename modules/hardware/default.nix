{ hardware, ... }:
let
  amdgpu = builtins.hasAttr "amdgpu" hardware && hardware.amdgpu;
  bluetooth = builtins.hasAttr "bluetooth" hardware && hardware.bluetooth;
  laptop = builtins.hasAttr "laptop" hardware && hardware.laptop;
  desktop = builtins.hasAttr "desktop" hardware && hardware.desktop;
  iso = builtins.hasAttr "iso" hardware && hardware.iso;
  displaylink = builtins.hasAttr "displaylink" hardware && hardware.displaylink;
in
{
  imports = [  ] ++
    (if (amdgpu) then [ ./amdgpu.nix ] else [ ]) ++
    (if (bluetooth) then [ ./bluetooth.nix ] else [ ]) ++
    (if (iso) then [ ./iso.nix ] else [  ]) ++
    (if (desktop || laptop || iso) then [ ./audio.nix ] else [ ]);
}