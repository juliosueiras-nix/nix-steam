{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "HouseParty";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "611790";
    platform = "windows";
  };

  gameFiles = gameFileInfo {
    inherit mainGameName;
    name = "HouseParty-Content";
    appId = "611790";
    platform = "windows";
    depotId = "611791";
    manifestId = "7975763465394150722";
  };

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
