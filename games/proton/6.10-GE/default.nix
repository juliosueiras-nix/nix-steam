{ stdenv }:

stdenv.mkDerivation {
  name = "Proton-6.10-GE";

  src = fetchTarball {
    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/6.10-GE-1/Proton-6.10-GE-1.tar.gz";
    sha256 = "0yibri0x6a4xxd8djavlsfap00gnf506r25cxpv50yglvi1a3rr1";
  };

  installPhase = ''
    mkdir -p $out
    cp -a * $out/
  '';
}
