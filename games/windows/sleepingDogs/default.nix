{ makeSteamGame, steamUserInfo, gameInfo, proton, gameFileInfo }:

let
  mainGameName = "SleepingDogs";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "307690";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "SleepingDogs-Exec";
      platform = "windows";
      appId = "307690";
      depotId = "307693	";
      manifestId = "521771309705279162";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "SleepingDogs-UI";
      platform = "windows";
      appId = "307690";
      depotId = "307692";
      manifestId = "8969342104525223947";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "SleepingDogs-Content";
      platform = "windows";
      appId = "307690";
      depotId = "307691";
      manifestId = "1259773366995347002";
    })
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
