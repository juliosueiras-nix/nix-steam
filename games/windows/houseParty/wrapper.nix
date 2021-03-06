{ protonWrapperScript, wineWowPackages, winetricks, curl, krb5, keyutils, game, proton, lib, steamcmd, steam, writeText, steam-run, writeScript, writeScriptBin, gameFiles, lndir, realGameLocation, gameFileInfo, steamGameFetcher, steamUserInfo, enableAdult ? false, ... }:

let
  gameFilesMod = gameFiles.overrideAttrs (old: {
    paths = old.paths ++ lib.optionals enableAdult [ 
      (import ./optional.nix {
        inherit steamUserInfo gameFileInfo steamGameFetcher;
      })
    ];
  });
in  writeScriptBin game.name ''
  ${
    protonWrapperScript {
      inherit game proton lndir lib steamUserInfo steamcmd steam realGameLocation;
      gameFiles = gameFilesMod;
    }
  }

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}/
    export WINEDLLOVERRIDES="dxgi=n" 
    export DXVK_HUD=1
    export WINEPREFIX=$PROTON_PREFIX_HOME/pfx
    export STEAM_COMPAT_DATA_PATH=$PROTON_PREFIX_HOME
    export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/steam

    $PROTON_HOME/proton waitforexitandrun ./HouseParty.exe	
  ''}
''
