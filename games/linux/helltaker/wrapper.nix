{ game, lib, steamcmd, steam-run-native, writeScript, writeScriptBin, gameFiles, steamUserInfo, lndir, ... }:

writeScriptBin game.name ''
  export SteamAppId=${game.appId}
  export HOME=/tmp/steam-test
  ${steamcmd}/bin/steamcmd +exit

  mkdir -p $HOME/games/${game.name}/manifests

  ${lndir}/bin/lndir ${steamUserInfo.targetStore}/${game.platform}/${game.name}/ $HOME/games/${game.name}/
  ${lndir}/bin/lndir ${gameFiles} $HOME/games/${game.name}/manifests
  chmod -R +rw $HOME/games/${game.name}

  rm $HOME/games/${game.name}/helltaker_lnx.x86_64	
  cp -L ${steamUserInfo.targetStore}/${game.platform}/${game.name}/helltaker_lnx.x86_64 $HOME/games/${game.name}/
  chmod -R +rwx $HOME/games/${game.name}/helltaker_lnx.x86_64

  ${lib.optionalString steamUserInfo.useGuardFiles ''
    cp -r ${steamUserInfo.cachedFileDir}/* $HOME/.steam/steam
  ''}

  chmod -R +rw $HOME/.steam
  ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
  ${steam-run-native}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}/
    exec ./helltaker_lnx.x86_64	
  ''}
''
