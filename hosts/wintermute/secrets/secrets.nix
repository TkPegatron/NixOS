let
    system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5ByRFmTMgJqTw6Hz7aMoD4C7o3wJcsV1rVa8ET81ih";
in {
    "wireguard.age".publicKeys = [ system ];
}