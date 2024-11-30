{ pkgs, user, ... }: {
  # Enable Display Manager
  services.greetd = {
    enable = true;
    settings = rec {
      login_required = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
      autologin = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = user.username;
      };
      default_session = autologin;
    };
  };
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];
}