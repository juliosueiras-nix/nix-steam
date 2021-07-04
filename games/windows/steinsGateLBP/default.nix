{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "SteinsGateLBP";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "930910";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "SteinsGateLBP-English";
      appId = "930910";
      platform = "windows";
      depotId = "930912";
      manifestId = "3342101974694904456";
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

  proton = proton.proton_6_10_ge;

  drvPath = ./wrapper.nix;
}
