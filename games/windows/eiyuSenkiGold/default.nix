{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "EiyuSenkiGold";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "1518430";
    platform = "windows";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "EiyuSenkiGold-Content";
    appId = "1518430";
    platform = "windows";
    depotId = "1518431";
    manifestId = "6978971977531136720";
  };

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
