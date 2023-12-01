{pkgs ? import <nixpkgs> {}}: {
  macos-cursors = pkgs.callPackage ./macos-cursors {};
  r2modman-elliana = pkgs.callPackage ./r2modman {};
}
