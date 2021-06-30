{ makeSteamGame, steamUserInfo, gameInfo, proton, gameFileInfo }:

let
  mainGameName = "ThereIsNoGame";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "1240210";
    platform = "windows";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "ThereIsNoGame";
    platform = "windows";
    appId = "1240210";
    depotId = "1240211";
    manifestId = "711553591273793860";
  };

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
