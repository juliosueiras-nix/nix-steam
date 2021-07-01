{ game, lib, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, linuxWrapperScript, realGameLocation, steacmdLogin, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/Umineko5to8
  cp -L ${realGameLocation}/Umineko5to8 $HOME/games/${game.name}/Umineko5to8

  chmod +rwx $HOME/games/${game.name}/Umineko5to8

  ${steacmdLogin { inherit steamUserInfo steamcmd; }}
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./Umineko5to8
  ''}
''
