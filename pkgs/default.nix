{pkgs ? import <nixpkgs> {}}: {
  macos-cursors = pkgs.callPackage ./macos-cursors {};
  r2modman-upstream = pkgs.callPackage ./r2modman {};
  vesktop-upstream = pkgs.callPackage ./vesktop {};
  genpass = pkgs.callPackage ./genpass {};
  drduh-gpg-conf = pkgs.callPackage ./drduh-gpg-conf {}; # https://github.com/dhess/nixos-yubikey/
  gpg-scripts = pkgs.callPackage ./gpg-scripts {}; # https://github.com/dhess/nixos-yubikey/
  yk-scripts = pkgs.callPackage ./yk-scripts {}; # https://github.com/dhess/nixos-yubikey/
}
