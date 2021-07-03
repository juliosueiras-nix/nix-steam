{ makeSteamGame, steamUserInfo, gameInfo, proton, gameFileInfo }:

let
  mainGameName = "offworld-trading-company";
  appId = "271240";
  gameFiles = (id: mid:
    gameFileInfo {
      inherit mainGameName appId;
      name = mainGameName;
      platform = "windows";
      depotId = id;
      manifestId = mid;
    });
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    inherit appId;
    name = mainGameName;
    platform = "windows";
  };

  gameFiles = [
    (gameFiles "271241" "4830695401179479638")
    (gameFiles "271243" "6513839327882495543")
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
