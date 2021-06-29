{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "UminekoAnswer";
    appId = "639490";
  };

  gameFiles = [
    (gameFileInfo {
      name = "UminekoAnswer";
      appId = "639490";
      depotId = "639491";
      manifestId = "876924491871297669";
    })

    (gameFileInfo {
      name = "UminekoQuestion-Linux";
      appId = "639490";
      depotId = "639492";
      manifestId = "857393923138543186";
    })
  ];

  drvPath = ./wrapper.nix;
}
