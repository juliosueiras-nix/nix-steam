{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Payday2";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "218620";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "Payday2";
      appId = "218620";
      depotId = "218632";
      manifestId = "1862813793011772620";
    })
  ];

  drvPath = ./wrapper.nix;
}
