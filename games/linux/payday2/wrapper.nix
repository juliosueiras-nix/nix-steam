{ game, lib, steam, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, realGameLocation, linuxWrapperScript, steamcmdLogin, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/payday2_release
  cp -L ${realGameLocation}/payday2_release $HOME/games/${game.name}/

  chmod +rwx $HOME/games/${game.name}/payday2_release

  STEAM_RUNNING="$(pgrep steam -c)"

  if [[ $STEAM_RUNNING == 0 ]]; then
    (${steam}/bin/steam -silent -login ${steamUserInfo.username} $(cat ${steamUserInfo.passwordFile}) &)
    sleep 60
  fi

  ${steamcmdLogin { inherit steamUserInfo steamcmd; }}
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    export LD_LIBRARY_PATH=$HOME/games/${game.name}:$LD_LIBRARY_PATH
    cd $HOME/games/${game.name}
    exec ./payday2_release
  ''}
''
