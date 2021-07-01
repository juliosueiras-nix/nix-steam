{ game, lib, steam, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, linuxWrapperScript, realGameLocation, steamcmdLogin, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/portal2.sh
  cp -L ${realGameLocation}/portal2.sh $HOME/games/${game.name}/portal2.sh

  rm $HOME/games/${game.name}/portal2_linux
  cp -L ${realGameLocation}/portal2_linux $HOME/games/${game.name}/portal2_linux

  chmod +rwx $HOME/games/${game.name}/portal2.sh
  chmod +rwx $HOME/games/${game.name}/portal2_linux

  STEAM_RUNNING="$(pgrep steam -c)"

  if [[ $STEAM_RUNNING == 0 ]]; then
    chmod -R +rw $HOME/.steam
    ${steamcmdLogin { inherit steamUserInfo steamcmd; }}
    (${steam}/bin/steam -silent -login ${steamUserInfo.username} $(cat ${steamUserInfo.passwordFile}) &)
    sleep 60
  fi

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./portal2.sh -game portal2 -steam
  ''}
''
