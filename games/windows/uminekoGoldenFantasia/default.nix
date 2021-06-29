{ makeSteamGame, steamUserInfo, gameInfo, proton, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "UminekoGoldenFantasia";
    appId = "550340";
  };

  gameFiles = gameFileInfo {
    name = "UminekoGoldenFantasia";
    platform = "windows";
    appId = "550340";
    depotId = "550341";
    manifestId = "25311086339845674";
  };

  proton = proton.proton_6_10_ge;

  drvPath = ./wrapper.nix;
}
