{ makeSteamGame, steamUserInfo, gameInfo, proton, gameFileInfo }:

let
  mainGameName = "UminekoGoldenFantasia";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "550340";
    platform = "windows";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "UminekoGoldenFantasia";
    platform = "windows";
    appId = "550340";
    depotId = "550341";
    manifestId = "25311086339845674";
  };

  proton = proton.proton_6_10_ge;

  drvPath = ./wrapper.nix;
}
