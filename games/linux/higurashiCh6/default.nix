{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "HigurashiCh6";
    appId = "668350";
  };

  gameFiles = gameFileInfo {
    name = "HigurashiCh6";
    appId = "668350";
    depotId = "668353";
    manifestId = "8690377579741694774";
  };

  drvPath = ./wrapper.nix;
}
