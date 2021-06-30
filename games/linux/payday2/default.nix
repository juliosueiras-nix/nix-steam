{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "Payday2";
    appId = "218620";
  };

  gameFiles = [
    (gameFileInfo {
      name = "Payday2";
      appId = "218620";
      depotId = "218632";
      manifestId = "1862813793011772620";
    })
  ];

  drvPath = ./wrapper.nix;
}
