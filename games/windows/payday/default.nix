{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = "Payday";
    appId = "24240";
  };

  gameFiles = [
    (gameFileInfo {
      name = "Payday-Content";
      appId = "24240";
      platform = "windows";
      depotId = "24241";
      manifestId = "2887059265933254853";
    })

    (gameFileInfo {
      name = "Payday-English";
      appId = "24240";
      platform = "windows";
      depotId = "24242";
      manifestId = "6469208572524230226";
    })
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
