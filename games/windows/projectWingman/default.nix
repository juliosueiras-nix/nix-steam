{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "ProjectWingman";
    appId = "895870";
  };

  gameFiles = gameFileInfo {
    name = "ProjectWingman-Content";
    appId = "895870";
    platform = "windows";
    depotId = "895871";
    manifestId = "1672280992675864586";
  };

  proton = proton.proton_6_10_ge;

  drvPath = ./wrapper.nix;
}
