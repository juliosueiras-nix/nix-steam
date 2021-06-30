{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Antichamber";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "219890";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "Antichamber";
    appId = "219890";
    depotId = "219893";
    manifestId = "1098988246616812101";

    installPhase = ''
      mkdir -p $out
      cp -a game/* $out
      cd $out/Binaries/Linux/lib/
      rm libogg.so libvorbis* libSDL2-2.0.so.0
      chmod +x $out/Binaries/Linux/UDKGame-Linux
    '';
  };

  drvPath = ./wrapper.nix;
}
