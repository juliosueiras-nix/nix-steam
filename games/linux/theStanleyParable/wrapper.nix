{ game, lib, steam, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, linuxWrapperScript, realGameLocation, steamcmdLogin, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/stanley
  cp -L ${realGameLocation}/stanley $HOME/games/${game.name}/

  rm $HOME/games/${game.name}/stanley_linux
  cp -L ${realGameLocation}/stanley_linux $HOME/games/${game.name}/

  chmod +rwx $HOME/games/${game.name}/stanley
  chmod +rwx $HOME/games/${game.name}/stanley_linux

  STEAM_RUNNING="$(pgrep steam -c)"

  if [[ $STEAM_RUNNING == 0 ]]; then
    chmod -R +rw $HOME/.steam
    ${steacmdLogin { inherit steamUserInfo steamcmd; }}
    (${steam}/bin/steam -silent -login ${steamUserInfo.username} $(cat ${steamUserInfo.passwordFile}) &)
    sleep 60
  fi

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./stanley -game thestanleyparable
  ''}
''
