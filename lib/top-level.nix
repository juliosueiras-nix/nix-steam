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
    export HOME=/tmp/steam-test
    mkdir -p $HOME/{protons/${proton.name}/prefix,games/${game.name}/manifests}
    ${steamcmd}/bin/steamcmd +exit
    ${lndir}/bin/lndir ${realGameLocation}/ $HOME/games/${game.name}/
    ${lndir}/bin/lndir ${gameFiles} $HOME/games/${game.name}/manifests
    chmod -R +rw $HOME/games/${game.name}

    if [[ ! -f "${proton}/${proton.name}/manifest.json" ]]; then
      cp -L -r ${proton}/* $HOME/protons/${proton.name}
    else
      cp -L -r ${steamUserInfo.targetStore}/linux/${proton.name}/* $HOME/protons/${proton.name}
      mkdir -p $HOME/protons/${proton.name}/manifests
      ${lndir}/bin/lndir ${proton} $HOME/protons/${proton.name}/manifests
    fi

    chmod +x $HOME/protons/${proton.name}/proton

    export PROTON_HOME=$HOME/protons/${proton.name}
    export PROTON_PREFIX_HOME=$PROTON_HOME/prefix

    ${lib.optionalString steamUserInfo.useGuardFiles ''
      cp -r ${steamUserInfo.cachedFileDir}/* $HOME/.steam/steam
    ''}

    STEAM_RUNNING="$(pgrep steam -c)"

    if [[ $STEAM_RUNNING == 0 ]]; then
      chmod -R +rw $HOME/.steam
      ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
      (${steam}/bin/steam -silent -login ${steamUserInfo.username} ${steamUserInfo.password} &)
      sleep 60
    fi
  '';

  linuxWrapperScript = { game, gameFiles, realGameLocation, lndir, lib, steamUserInfo, steamcmd }: ''
    export SteamAppId=${game.appId}
    export HOME=/tmp/steam-test
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


  makeSteamGame = callPackage ./make-steam-game.nix {
    inherit steamGameFetcher callPackage protonWrapperScript linuxWrapperScript;
  };
}
