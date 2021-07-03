{ callPackage, nixpkgsSource }:

rec {
  steamUserInfo = import ./steam-user.nix;
  gameInfo = import ./game-info.nix;
  gameFileInfo = import ./game-file-info.nix;
  steamGameFetcher = callPackage ./game-files-fetcher.nix {
    inherit nixpkgsSource;
  };

  protonWrapperScript = { game, gameFiles, realGameLocation, proton, lndir, lib, steamUserInfo, steamcmd, steam }: ''
    export SteamAppId=${game.appId}
    export HOME=${steamUserInfo.outputStore}
    mkdir -p $HOME/{protons/${proton.name}/{prefix,proton},games/${game.name}/manifests}
    ${steamcmd}/bin/steamcmd +exit
    ${lndir}/bin/lndir ${realGameLocation}/ $HOME/games/${game.name}/
    ${lndir}/bin/lndir ${gameFiles} $HOME/games/${game.name}/manifests
    chmod -R +rw $HOME/games/${game.name}

    if [[ ! -f "${proton}/${proton.name}/manifest.json" ]]; then
      cp -L -r ${proton}/* $HOME/protons/${proton.name}/proton
    else
      cp -L -r ${steamUserInfo.targetStore}/linux/${proton.name}/* $HOME/protons/${proton.name}/proton
      mkdir -p $HOME/protons/${proton.name}/proton/manifests
      ${lndir}/bin/lndir ${proton} $HOME/protons/${proton.name}/proton/manifests
    fi

    chmod +x $HOME/protons/${proton.name}/proton/proton
    chmod -R +rw $HOME/protons/${proton.name}/proton

    export PROTON_HOME=$HOME/protons/${proton.name}/proton
    export PROTON_PREFIX_HOME=$PROTON_HOME/../prefix

    ${lib.optionalString steamUserInfo.useGuardFiles ''
      cp -r ${steamUserInfo.cachedFileDir}/* $HOME/.steam/steam
    ''}

    STEAM_RUNNING="$(pgrep steam -c)"

    if [[ $STEAM_RUNNING == 0 ]]; then
      chmod -R +rw $HOME/.steam
      ${steamcmdLogin { inherit steamUserInfo steamcmd; } }
      (${steam}/bin/steam -silent -login ${steamUserInfo.username} $(cat ${steamUserInfo.passwordFile})  &)
      sleep 60
    fi
  '';

  linuxWrapperScript = { game, gameFiles, realGameLocation, lndir, lib, steamUserInfo, steamcmd }: ''
    export SteamAppId=${game.appId}
    export HOME=${steamUserInfo.outputStore}
    mkdir -p $HOME/games/${game.name}/manifests
    ${lndir}/bin/lndir ${realGameLocation} $HOME/games/${game.name}
    ${lndir}/bin/lndir ${gameFiles} $HOME/games/${game.name}/manifests
    chmod -R +rw $HOME/games/${game.name}

    ${steamcmd}/bin/steamcmd +exit

    ${lib.optionalString steamUserInfo.useGuardFiles ''
      cp -r ${steamUserInfo.cachedFileDir}/* $HOME/.steam/steam
    ''}

    chmod -R +rw $HOME/.steam
  '';

  steamcmdLogin = { steamUserInfo, steamcmd }: ''
    ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} $(cat ${steamUserInfo.passwordFile}) +exit
  '';

  makeSteamGame = callPackage ./make-steam-game.nix {
    inherit gameFileInfo steamGameFetcher callPackage protonWrapperScript linuxWrapperScript steamcmdLogin;
  };
}
