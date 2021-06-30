{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "HigurashiCh6";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "668350";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "HigurashiCh6";
    appId = "668350";
    depotId = "668353";
    manifestId = "8690377579741694774";
  };

  drvPath = ./wrapper.nix;
}
