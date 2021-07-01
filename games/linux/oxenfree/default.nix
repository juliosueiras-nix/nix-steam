{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Oxenfree";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "388880";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "Oxenfree-Linux-Universal-Content";
      appId = "388880";
      depotId = "388884";
      manifestId = "8028188999286703994";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "Oxenfree-SteamAPI-x64";
      appId = "388880";
      depotId = "388885";
      manifestId = "760220395727681197";
    })
  ];

  drvPath = ./wrapper.nix;
}
