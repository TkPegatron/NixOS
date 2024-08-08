final: prev: {
  macos-cursors = prev.callPackage ./macos-cursors {};
  r2modman-upstream = prev.callPackage ./r2modman {};
  vesktop-upstream = prev.callPackage ./vesktop {};
  genpass = prev.callPackage ./genpass {};
  drduh-gpg-conf = prev.callPackage ./drduh-gpg-conf {}; # https://github.com/dhess/nixos-yubikey/
  gpg-scripts = prev.callPackage ./gpg-scripts {}; # https://github.com/dhess/nixos-yubikey/
  yk-scripts = prev.callPackage ./yk-scripts {}; # https://github.com/dhess/nixos-yubikey/
  drduh-gpg-guide = prev.callPackage ./drduh-gpg-guide {};
}
