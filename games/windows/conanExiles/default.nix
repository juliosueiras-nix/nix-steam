{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "ConanExiles";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "440900";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "ConanExiles-Content";
      appId = "440900";
      platform = "windows";
      depotId = "440901";
      manifestId = "5982054116698208447";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "ConanExiles-Binaries";
      appId = "440900";
      platform = "windows";
      depotId = "440902";
      manifestId = "6773317510006853756";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "ConanExiles-Client-Launcher";
      appId = "440900";
      platform = "windows";
      depotId = "440903";
      manifestId = "6051424170071502041";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "VC-2015-Redist";
      appId = "228980";
      platform = "windows";
      depotId = "228986";
      manifestId = "8782296191957114623";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "DirextX-Redist";
      appId = "228980";
      platform = "windows";
      depotId = "228990";
      manifestId = "1829726630299308803";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "Steam-Linux-Runtime-Soldier";
      appId = "1391110";
      platform = "windows";
      depotId = "1391111";
      manifestId = "6193391955085222289";
    })
  ];

  proton = proton.proton_6_10_ge;

  drvPath = ./wrapper.nix;
}
