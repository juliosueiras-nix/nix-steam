{ protonWrapperScript, curl, krb5, keyutils, game, proton, lib, steamcmd, steam, writeText, steam-run, writeScript, writeScriptBin, gameFiles, lndir, steamUserInfo, ... }:

writeScriptBin game.name ''
  ${
    protonWrapperScript {
      inherit game gameFiles proton lndir lib steamUserInfo steamcmd steam;
    }
  }

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}/
    export LD_LIBRARY_PATH=${lib.makeLibraryPath [ curl krb5 keyutils ]}:$LD_LIBRARY_PATH
    export WINEDLLOVERRIDES="dxgi=n" 
    export DXVK_HUD=1
    export WINEPREFIX=$PROTON_PREFIX_HOME/pfx
    export STEAM_COMPAT_DATA_PATH=$PROTON_PREFIX_HOME
    export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/steam

    $HOME/protons/${proton.name}/proton waitforexitandrun ./ProjectWingman.exe -nohmd
  ''}
''
