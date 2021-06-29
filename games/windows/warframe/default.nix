{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "Warframe";
    appId = "230410";
  };

  gameFiles = gameFileInfo {
    name = "Warframe";
    appId = "230410";
    platform = "windows";
    depotId = "230411";
    manifestId = "896988770099174429";
  };

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
