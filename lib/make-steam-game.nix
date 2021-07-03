{ callPackage, gameFileInfo, steamGameFetcher, jq, lib, symlinkJoin, protonWrapperScript, linuxWrapperScript, linkFarm, runCommand, steamcmdLogin  }:

{ steamUserInfo, game, gameFiles, drvPath, proton ? null }:

let
  gameFilesMod = if (lib.isList gameFiles) then gameFiles else [ gameFiles ];
in callPackage drvPath {
  realGameLocation = "${steamUserInfo.targetStore}/${game.platform}/${game.name}";
  inherit game gameFileInfo steamGameFetcher steamUserInfo proton steamcmdLogin protonWrapperScript linuxWrapperScript;
  gameFiles = symlinkJoin {
    name = "${game.name}-files";

    paths = lib.forEach gameFilesMod (gameFile:
    steamGameFetcher {
      inherit steamUserInfo;
      game = gameFile;
    });
  };
}
