{ makeSteamGame, proton, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Katana-Zero";
  appId = "460950";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    inherit appId;
    name = mainGameName;
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName appId;
      name = "Katana-ZERO-Content";
      platform = "windows";
      depotId = "460951";
      manifestId = "7302141199497370222";
    })
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
