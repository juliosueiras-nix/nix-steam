{ steamUserInfo, gameFileInfo, steamGameFetcher }:

steamGameFetcher {
  inherit steamUserInfo;
  game = gameFileInfo {
    mainGameName = "HouseParty";
    name = "HouseParty-ExplicitContent";
    appId = "611790";
    platform = "windows";
    depotId = "944540";
    manifestId = "1811577398040335252";
  };
}
