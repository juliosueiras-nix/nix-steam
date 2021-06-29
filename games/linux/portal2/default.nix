{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "Portal2";
    appId = "620";
  };

  gameFiles = [
    (gameFileInfo {
      name = "Portal2-Client-Binaries";
      appId = "620";
      depotId = "624";
      manifestId = "1941148049629049074";
    })

    (gameFileInfo {
      name = "Portal2-Common";
      appId = "620";
      depotId = "621";
      manifestId = "8379316869136765904";
    })

    (gameFileInfo {
      name = "Portal2-Linux-Content";
      appId = "620";
      depotId = "661";
      manifestId = "1379718481839503052";
    })
  ];

  drvPath = ./wrapper.nix;
}
