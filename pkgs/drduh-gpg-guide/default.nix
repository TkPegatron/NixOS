{ stdenv
, lib
, fetchFromGitHub
}:

let

  version = "20240722";

  src = fetchFromGitHub {
    owner = "drduh";
    repo = "YubiKey-Guide";
    rev = "d9af1dea5014a229ddd639c30f7628bda7acf311";
    sha256 = "xHsdj0ui2YzWNxUHbOXrvB73blIui9dwScKtzoruJxs=";
  };

in
stdenv.mkDerivation {
  name = "drduh-gpg-guide-${version}";

  inherit src;

  dontBuild = true;

  installPhase = ''
    mkdir $out
    cp -r $src/* $out/
  '';

  meta = with lib; {
    description = "drduh's gpg guide";
    homepage    = https://github.com/drduh/YubiKey-Guide;
    license     = licenses.mit;
  };
}
