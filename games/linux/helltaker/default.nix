{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Helltaker";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "1289310";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "Helltaker";
      appId = "1289310";
      depotId = "1289314";
      manifestId = "8723838119065609357";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "Helltaker-Local";
      appId = "1289310";
      depotId = "1289315";
      manifestId = "6394422377711576735";
    })
  ];

  drvPath = ./wrapper.nix;
}
