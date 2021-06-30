{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Warframe";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "230410";
    platform = "windows";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "Warframe";
    appId = "230410";
    platform = "windows";
    depotId = "230411";
    manifestId = "896988770099174429";
  };

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
