{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "Proton6_3";
    appId = "1580130";
  };

  gameFiles = gameFileInfo {
    mainGameName = "Proton6_3";
    name = "Proton6_3";
    appId = "1580130";
    depotId = "1580131";
    manifestId = "7336486418625335787";
  };

  drvPath = ./wrapper.nix;
}
