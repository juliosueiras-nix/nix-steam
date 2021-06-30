{ makeSteamGame, steamUserInfo, gameInfo, proton, gameFileInfo }:

let
  mainGameName = "JustCause";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "6880";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "JustCause-Binaries";
      platform = "windows";
      appId = "6880";
      depotId = "6881";
      manifestId = "6527771220312814148";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "JustCause-FMV1";
      platform = "windows";
      appId = "6880";
      depotId = "6882";
      manifestId = "4589612640979803544";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "JustCause-FMV2";
      platform = "windows";
      appId = "6880";
      depotId = "6883";
      manifestId = "4806707053551780261";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "JustCause-PC01";
      platform = "windows";
      appId = "6880";
      depotId = "6888";
      manifestId = "70519445597708639";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "JustCause-PC02";
      platform = "windows";
      appId = "6880";
      depotId = "6889";
      manifestId = "6899635947800562820";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "JustCause-PC03";
      platform = "windows";
      appId = "6880";
      depotId = "6890";
      manifestId = "332007685201679804";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "JustCause-PC04";
      platform = "windows";
      appId = "6880";
      depotId = "6891";
      manifestId = "4619176749946730386";
    })
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
