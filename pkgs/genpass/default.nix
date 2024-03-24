{ lib,
  stdenv,
  fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "genpass";
  version = "0.0.10";

  src = fetchFromGitHub {
    owner = "tkpegatron";
    repo = "genpass";
    rev = "v${version}";
    hash = "sha256-MRJsJjplXI+SvJlUF0bGL3bbipokzPYFQWoQr/1zr/k=";
  };

  installPhase = ''
    install -m755 -D genpass_amd64 $out/bin/genpass
  '';

  meta = with lib; {
    description = "Password generator written in rust";
    homepage = "https://github.com/tkpegatron/genpass";
    changelog = "https://github.com/tkpegatron/genpass/releases/tag/v${version}";
    platforms = platforms.linux;
  };
}
