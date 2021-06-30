{ makeSteamGame, steamUserInfo, gameInfo, proton, gameFileInfo }:

let
  mainGameName = "AlanWake";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "108710";
    platform = "windows";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "AlanWake-2020-Fix";
      platform = "windows";
      appId = "108710";
      depotId = "108711";
      manifestId = "6213019430359665046";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "AlanWake-ThirdParty";
      platform = "windows";
      appId = "108710";
      depotId = "108712";
      manifestId = "901025420359456534";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "AlanWake-Datas";
      platform = "windows";
      appId = "108710";
      depotId = "108725";
      manifestId = "1993621679641115397";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "AlanWake-Videos";
      platform = "windows";
      appId = "108710";
      depotId = "108724";
      manifestId = "8702697917673304354";
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "AlanWake-ExesAndShaders";
      platform = "windows";
      appId = "108710";
      depotId = "108723";
      manifestId = "5060317705156608793";
    })
  ];

  proton = proton.proton_6_3;

  drvPath = ./wrapper.nix;
}
