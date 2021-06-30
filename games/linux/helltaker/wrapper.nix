{ game, lib, steamcmd, steam-run-native, writeScript, writeScriptBin, gameFiles, steamUserInfo, lndir, linuxWrapperScript, realGameLocation, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/helltaker_lnx.x86_64	
  cp -L ${realGameLocation}/helltaker_lnx.x86_64 $HOME/games/${game.name}/
  chmod -R +rwx $HOME/games/${game.name}/helltaker_lnx.x86_64

  ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
  ${steam-run-native}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}/
    exec ./helltaker_lnx.x86_64	
  ''}
''
