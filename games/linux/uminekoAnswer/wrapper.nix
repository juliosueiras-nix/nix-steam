{ game, lib, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, ... }:

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

  rm $HOME/games/${game.name}/Umineko5to8
  cp -L ${gameFiles}/Umineko5to8 $HOME/games/${game.name}/Umineko5to8

  chmod +rwx $HOME/games/${game.name}/Umineko5to8

  chmod -R +rw $HOME/.steam
  ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./Umineko5to8
  ''}
''
