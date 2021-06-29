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
      hash = "6uE2U07k0kIiMTjOeooQix0IjiU9riTDxr/QjXE7BaQ=";
    })

    (gameFileInfo {
      name = "Helltaker-Local";
      appId = "1289310";
      depotId = "1289315";
      manifestId = "6394422377711576735";
      hash = "tZGkRGaU8KIIGfbo5GvY9eOFtP7Ua7gkZGDyzTe+UnI=";
    })
  ];

  drvPath = ./wrapper.nix;
}
