{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "ShenzhenIO";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "504210";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "ShenzhenIO";
      appId = "504210";
      depotId = "504213";
      manifestId = "8236289999055455317";
    })
  ];

  drvPath = ./wrapper.nix;
}
