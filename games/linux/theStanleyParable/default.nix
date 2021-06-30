{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "TheStanleyParable";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "221910";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "TheStanleyParable-Content";
      appId = "221910";
      depotId = "221911";
      manifestId = "4574887516115604592";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "TheStanleyParable-Tea-Edition";
      appId = "221910";
      depotId = "221914";
      manifestId = "4819957267483375851";
    })
  ];

  drvPath = ./wrapper.nix;
}
