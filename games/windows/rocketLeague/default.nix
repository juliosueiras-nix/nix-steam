{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let 
  mainGameName = "RocketLeague";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "252950";
    platform = "windows";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "RocketLeague";
    appId = "252950";
    platform = "windows";
    depotId = "252951";
    manifestId = "2273576982621900744";
  };

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
