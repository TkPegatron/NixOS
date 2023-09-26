let
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGLsOGawbjb38O+mxEYKjDY4XoRzzTqJ8KGRSEVZWO6E";
in {
  "syncthing.age".publicKeys = [ system ];
}
