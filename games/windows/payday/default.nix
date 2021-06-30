{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "JustCause";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "24240";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "Payday-Content";
      appId = "24240";
      platform = "windows";
      depotId = "24241";
      manifestId = "2887059265933254853";
    })

    (gameFileInfo {
      inherit mainGameName;
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
