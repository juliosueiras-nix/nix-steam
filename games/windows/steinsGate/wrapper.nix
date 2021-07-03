{ protonWrapperScript, wineWowPackages, winetricks, curl, krb5, keyutils, game, proton, lib, steamcmd, steam, writeText, steam-run, writeScript, writeScriptBin, gameFiles, lndir, realGameLocation, steamUserInfo, ... }:

let
  winetricksMod = winetricks.override {
    wine = null;
  };
in writeScriptBin game.name ''
  ${
    protonWrapperScript {
      inherit game gameFiles proton lndir lib steamUserInfo steamcmd steam realGameLocation;
    }
  }

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    export LD_LIBRARY_PATH=${lib.makeLibraryPath [ curl krb5 keyutils ]}:$LD_LIBRARY_PATH
    cd $HOME/games/${game.name}/
    export WINEDLLOVERRIDES="dxgi=n" 
    export DXVK_HUD=1
    export WINEPREFIX=$PROTON_PREFIX_HOME/pfx
    export STEAM_COMPAT_DATA_PATH=$PROTON_PREFIX_HOME
    export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/steam
    export PATH=$PATH:$PROTON_HOME/dist/bin
    
    $PROTON_HOME/proton waitforexitandrun ./_CommonRedist/DirectX/Jun2010/DXSETUP.exe /silent
    $PROTON_HOME/proton waitforexitandrun ./Launcher.exe
  ''}
''
