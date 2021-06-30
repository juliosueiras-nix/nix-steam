{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "ProjectWingman";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "895870";
    platform = "windows";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "ProjectWingman-Content";
    appId = "895870";
    platform = "windows";
    depotId = "895871";
    manifestId = "1672280992675864586";
  };

  proton = proton.proton_6_10_ge;

  drvPath = ./wrapper.nix;
}
