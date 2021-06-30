{ callPackage, steamGameFetcher, jq, lib, symlinkJoin, protonWrapperScript, linuxWrapperScript, linkFarm, runCommand }:

{ steamUserInfo, game, gameFiles, drvPath, proton ? null }:

callPackage drvPath {
  realGameLocation = "${steamUserInfo.targetStore}/${game.platform}/${game.name}";
  inherit game steamUserInfo proton protonWrapperScript linuxWrapperScript;
  gameFiles = if !(lib.isList gameFiles) then steamGameFetcher {
    inherit steamUserInfo;
    game = gameFiles;
  } else symlinkJoin {
    name = "${game.name}-files";

    paths = lib.forEach gameFiles (gameFile:
    steamGameFetcher {
      inherit steamUserInfo;
      game = gameFile;
    });
  };
}
