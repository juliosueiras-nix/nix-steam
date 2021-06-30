{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "SteinsGate0";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "825630";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "SteinsGate0-English";
      appId = "825630";
      platform = "windows";
      depotId = "825632";
      manifestId = "2281959220695080388";
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
