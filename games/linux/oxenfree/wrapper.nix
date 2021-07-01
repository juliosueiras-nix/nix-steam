{ game, lib, steamcmd, steam-run-native, writeScript, writeScriptBin, gameFiles, steamUserInfo, lndir, linuxWrapperScript, realGameLocation, steamcmdLogin, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/Oxenfree.x86_64	
  cp -L ${realGameLocation}/Oxenfree.x86_64 $HOME/games/${game.name}/
  chmod -R +rwx $HOME/games/${game.name}/Oxenfree.x86_64

  ${steamcmdLogin { inherit steamUserInfo steamcmd; }}
  ${steam-run-native}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}/
    exec ./Oxenfree.x86_64	
  ''}
''
