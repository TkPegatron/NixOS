{pkgs ? import <nixpkgs> {}}: {
  macos-cursors = pkgs.callPackage ./macos-cursors {};
  r2modman-upstream = pkgs.callPackage ./r2modman {};
  vesktop-upstream = pkgs.callPackage ./vesktop {};
  genpass = pkgs.callPackage ./genpass {};
}
