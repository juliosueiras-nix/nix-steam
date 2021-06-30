{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "SteinsGateElite";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "819030";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "SteinsGateElite-English";
      appId = "819030";
      platform = "windows";
      depotId = "819032";
      manifestId = "5436224210371133763";
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
