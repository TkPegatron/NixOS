{ pkgs, ... }: {
  # Disable pulseaudio
  hardware.pulseaudio.enable = false;
  # Enable and configure Pipewire
  services.pipewire = {
    enable = true;
    # Compatibility shims for other audioservers
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # Enable X.org server
  services.xserver.enable = true;
  # Enable libinput and confgure touchpad
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad = {
    disableWhileTyping = true;
    clickMethod = "clickfinger";
  };
  # Install desired system graphical packages
  environment.systemPackages = with pkgs; [
    celluloid # MPV Frontend
    # Havent Decided between these two yet
    qimgv libsForQt5.gwenview
  ];
}
