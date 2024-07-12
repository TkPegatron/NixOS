{ pkgs, pkgs-unstable, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
    ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    package = pkgs-unstable.mesa.drivers;
  };
  hardware.enableRedistributableFirmware = true;
}