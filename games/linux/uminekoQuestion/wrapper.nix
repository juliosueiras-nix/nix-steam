{ game, lib, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, linuxWrapperScript, realGameLocation, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/Umineko1to4
  cp -L ${realGameLocation}/Umineko1to4 $HOME/games/${game.name}/Umineko1to4

  chmod +rwx $HOME/games/${game.name}/Umineko1to4

  ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./Umineko1to4
  ''}
''
