{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Brawlhalla";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "291550";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "Brawlhalla-Content";
      appId = "291550";
      platform = "windows";
      depotId = "291551";
      manifestId = "1720424793603833496";
    })
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
