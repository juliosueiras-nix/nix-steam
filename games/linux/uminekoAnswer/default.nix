{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "UminekoAnswer";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "639490";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "UminekoAnswer";
      appId = "639490";
      depotId = "639491";
      manifestId = "876924491871297669";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "UminekoQuestion-Linux";
      appId = "639490";
      depotId = "639492";
      manifestId = "857393923138543186";
    })
  ];

  drvPath = ./wrapper.nix;
}
