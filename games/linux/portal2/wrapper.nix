{ game, lib, steam, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, ... }:

writeScriptBin game.name ''
  export SteamAppId=${game.appId}
  export HOME=/tmp/steam-test
  mkdir -p $HOME/games/${game.name}
  ${steamcmd}/bin/steamcmd +exit

  ${lib.optionalString steamUserInfo.useGuardFiles ''
    cp -r ${steamUserInfo.cachedFileDir}/* $HOME/.steam/steam
  ''}

  ${lndir}/bin/lndir ${gameFiles} $HOME/games/${game.name}
  chmod -R +rw $HOME/games/${game.name}

  rm $HOME/games/${game.name}/portal2.sh
  cp -L ${gameFiles}/portal2.sh $HOME/games/${game.name}/portal2.sh

  rm $HOME/games/${game.name}/portal2_linux
  cp -L ${gameFiles}/portal2_linux $HOME/games/${game.name}/portal2_linux

  chmod +rwx $HOME/games/${game.name}/portal2.sh
  chmod +rwx $HOME/games/${game.name}/portal2_linux

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
    exec ./portal2.sh -game portal2 -steam
  ''}
''
