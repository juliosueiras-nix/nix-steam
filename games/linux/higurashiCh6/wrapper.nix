{ game, lib, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, linuxWrapperScript, realGameLocation,  ... }:

in writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./HigurashiEp06.x86	
  ''}
''
