{ pkgs, ... }: {
  # Enable X.org server
  services.xserver.enable = true;
  # Enable libinput and confgure touchpad
  services.libinput.enable = true;
  services.libinput.touchpad = {
    disableWhileTyping = true;
    clickMethod = "clickfinger";
  };
}