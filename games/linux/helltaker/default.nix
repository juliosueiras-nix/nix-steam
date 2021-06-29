{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "Helltaker";
    appId = "1289310";
  };

  gameFiles = [
    (gameFileInfo {
      name = "Helltaker";
      appId = "1289310";
      depotId = "1289314";
      manifestId = "8723838119065609357";
    })

    (gameFileInfo {
      name = "Helltaker-Local";
      appId = "1289310";
      depotId = "1289315";
      manifestId = "6394422377711576735";
    })
  ];

  drvPath = ./wrapper.nix;
}
