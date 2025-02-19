{ lib, ... }: {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    extraConfig = ''
      # Accept signed user certificates
      TrustedUserCAKeys /etc/ssh/ssh_user_ca-zynthovian-xyz.pub
    '';
    openFirewall = true;
  };
  environment.enableAllTerminfo = true;
  environment.etc = {
    "ssh/ssh_user_ca-zynthovian-xyz.pub" = {
      text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIELT32sxN9BC+TPDSibvf72B5RY56U97W3d7ksP7NsZM ssh-user-ca@zynthovian.xyz";
      mode = "0644";
    };
  };
}