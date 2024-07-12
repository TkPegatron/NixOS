{ pkgs, ... }: {
  # Enable X.org server
  services.xserver.enable = true;
  # Enable libinput and confgure touchpad
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad = {
    disableWhileTyping = true;
    clickMethod = "clickfinger";
  };
}