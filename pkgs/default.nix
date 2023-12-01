{pkgs ? import <nixpkgs> {}}: {
  macos-cursors = pkgs.callPackage ./macos-cursors {};
}
