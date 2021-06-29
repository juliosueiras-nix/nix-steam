{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "UminekoQuestion";
    appId = "406550";
  };

  gameFiles = [
    (gameFileInfo {
      name = "UminekoQuestion";
      appId = "406550";
      depotId = "406551";
      manifestId = "8049229731852969071";
    })

    (gameFileInfo {
      name = "UminekoQuestion-Linux";
      appId = "406550";
      depotId = "406552";
      manifestId = "1458265691352860752";
    })
  ];

  drvPath = ./wrapper.nix;
}
