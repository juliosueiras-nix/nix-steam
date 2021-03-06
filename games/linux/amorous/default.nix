{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Amorous";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "778700";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "Amorous";
      appId = "778700";
      depotId = "778704";
      manifestId = "1910947975998266938";

      extraAction = ''
        chmod +x game/*.bin*
      '';
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "Amorous-Content";
      appId = "778700";
      depotId = "778701";
      manifestId = "9201582490132012031";
    })
  ];

  drvPath = ./wrapper.nix;
}
