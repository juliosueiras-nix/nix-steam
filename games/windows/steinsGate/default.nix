{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "SteinsGate";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "412830";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "SteinsGate-English";
      appId = "412830";
      platform = "windows";
      depotId = "412831";
      manifestId = "4258046810370830803";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "DirectX-2010-Redist";
      appId = "228980";
      platform = "windows";
      depotId = "228990";
      manifestId = "1829726630299308803";
    })
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
