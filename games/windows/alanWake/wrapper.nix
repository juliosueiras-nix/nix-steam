{ game, proton, lib, steamcmd, steam, writeText, steam-run, writeScript, writeScriptBin, gameFiles, lndir, steamUserInfo, protonWrapperScript, realGameLocation, enableDeveloperCommentary ? false, steamGameFetcher, gameFileInfo, ... }:

let
  # Developer Commentary not working right now, need to find out how to enable it
  gameFilesMod = gameFiles.overrideAttrs (old: {
    paths = old.paths ++ lib.optionals enableDeveloperCommentary [ 
      (import ./optional.nix {
        inherit steamGameFetcher steamUserInfo gameFileInfo;
      })
    ];
  });
in writeScriptBin game.name ''
  ${
    protonWrapperScript {
      inherit game proton lndir lib steamUserInfo steamcmd steam realGameLocation;
      gameFiles = gameFilesMod;
    }
  }

  rm $HOME/games/${game.name}/AlanWake.exe
  cp -L ${realGameLocation}/AlanWake.exe $HOME/games/${game.name}/

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    export WINEDLLOVERRIDES="xaudio2_7=b,n" 
    export DXVK_HUD=1
    export PROTON_NO_D3D11
    export PROTON_NO_D3D10
    export WINEPREFIX=$PROTON_PREFIX_HOME/pfx
    export STEAM_COMPAT_DATA_PATH=$PROTON_PREFIX_HOME
    export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/steam
    export PROTON_FORCE_LARGE_ADDRESS_AWARE=1

    $PROTON_HOME/proton waitforexitandrun ./thirdparty/DirectX/DXSETUP.exe /silent
    $PROTON_HOME/proton waitforexitandrun ./thirdparty/Studio_Redistributable/vcredist_x86.exe /q
    $PROTON_HOME/proton waitforexitandrun ./AlanWake.exe
  ''}
''
