{ game, lib, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, linuxWrapperScript, realGameLocation, steacmdLogin, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  ${steacmdLogin { inherit steamUserInfo steamcmd; }}
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    export LD_LIBRARY_PATH=${realGameLocation}/Binaries/Linux/lib:$LD_LIBRARY_PATH
    cd $HOME/games/${game.name}
    exec ./UDKGame-Linux
  ''}
''
