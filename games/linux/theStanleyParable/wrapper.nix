{ game, lib, steam, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, linuxWrapperScript, realGameLocation, ... }:

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
    ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
    (${steam}/bin/steam -silent -login ${steamUserInfo.username} ${steamUserInfo.password} &)
    sleep 60
  fi

  chmod -R +rw $HOME/.steam
  ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./stanley -game thestanleyparable
  ''}
''
