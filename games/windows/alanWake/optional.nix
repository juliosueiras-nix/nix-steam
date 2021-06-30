{ steamGameFetcher, steamUserInfo, gameFileInfo }:

steamGameFetcher {
  inherit steamUserInfo;
  game = gameFileInfo {
    mainGameName = "AlanWake";
    name = "AlanWake-Developer-Commentary";
    platform = "windows";
    appId = "108710";
    depotId = "108726";
    manifestId = "1713738522381113009";
  };
}
