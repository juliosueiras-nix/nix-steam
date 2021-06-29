{ callPackage, steamGameFetcher, jq, lib, symlinkJoin, protonWrapperScript, linkFarm, runCommand }:

{ steamUserInfo, game, gameFiles, drvPath, proton ? null }:

callPackage drvPath {
  inherit game steamUserInfo proton protonWrapperScript;
  gameFiles = if !(lib.isList gameFiles) then steamGameFetcher {
    inherit steamUserInfo;
    game = gameFile;
  } else symlinkJoin {
    name = "${game.name}-files";

    paths = lib.forEach gameFiles (gameFile:
    steamGameFetcher {
      inherit steamUserInfo;
      game = gameFile;
    });
  };
}
