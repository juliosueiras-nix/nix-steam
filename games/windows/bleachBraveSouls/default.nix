{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "BleachBraveSouls";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "1201240";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "BleachBraveSouls-Content";
      appId = "1201240";
      platform = "windows";
      depotId = "1201241";
      manifestId = "2130923254481654352";
    })
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
