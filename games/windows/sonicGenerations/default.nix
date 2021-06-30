{ makeSteamGame, steamUserInfo, gameInfo, proton, gameFileInfo }:

let
  mainGameName = "SonicGenerations";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "71340";
    platform = "windows";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "SonicGenerations";
    platform = "windows";
    appId = "71340";
    depotId = "71341";
    manifestId = "190831558827569965";
  };

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
