{ game, lib, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, linuxWrapperScript, realGameLocation, steamcmdLogin, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/Umineko1to4
  cp -L ${realGameLocation}/Umineko1to4 $HOME/games/${game.name}/Umineko1to4

  chmod +rwx $HOME/games/${game.name}/Umineko1to4

  ${steacmdLogin { inherit steamUserInfo steamcmd; }}
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./Umineko1to4
  ''}
''
