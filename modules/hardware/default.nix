{ hardware, ... }:
let
  amdgpu = builtins.hasAttr "amdgpu" hardware && hardware.amdgpu;
  bluetooth = builtins.hasAttr "bluetooth" hardware && hardware.bluetooth;
  laptop = builtins.hasAttr "laptop" hardware && hardware.laptop;
  desktop = builtins.hasAttr "desktop" hardware && hardware.desktop;
  guest = builtins.hasAttr "guest" hardware && hardware.guest;
  hypervisor = builtins.hasAttr "hypervisor" hardware && hardware.hypervisor;
  iso = builtins.hasAttr "iso" hardware && hardware.iso;
in
{
  imports = [  ] ++
    (if (iso) then [ ./iso.nix ] else [  ]) ++
    (if (amdgpu) then [ ./amdgpu.nix ] else [  ]) ++
    (if (guest) then [ ./guest.nix ] else [  ]) ++
    (if (hypervisor) then [ ./hypervisor.nix ] else [  ]) ++
    (if (bluetooth) then [ ./bluetooth.nix ] else [  ]) ++
    (if (desktop || laptop || iso) then [ ./audio.nix ] else [  ]);
}