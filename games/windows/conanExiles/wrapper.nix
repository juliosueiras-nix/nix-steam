{ protonWrapperScript, game, proton, lib, steamcmd, steam, writeText, steam-run, writeScript, writeScriptBin, gameFiles, lndir, realGameLocation, steamUserInfo, ... }:

# 1. Need to add option to override Windows.Engine:OnlineSubsystemSteam:ListenServerQueryPort:0=27215 to another port to avoid the failed login issue
# 2. Might need to chmod the targetStore ConanExiles to allow player to play
# 3. Need to add option to change screen mode to avoid fullscreen crash
writeScriptBin game.name ''
  ${
    protonWrapperScript {
      inherit game gameFiles proton lndir lib steamUserInfo steamcmd steam realGameLocation;
    }
  }

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd ${steamUserInfo.targetStore}/windows/ConanExiles/
    export WINEDLLOVERRIDES="dxgi=n" 
    export DXVK_HUD=1
    export WINEPREFIX=$PROTON_PREFIX_HOME/pfx
    export STEAM_COMPAT_DATA_PATH=$PROTON_PREFIX_HOME
    export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/steam
    export WINEESYNC=1
    export WINEFSYNC=1
    export PROTON_LOG=1
    
    $PROTON_HOME/proton waitforexitandrun $HOME/games/${game.name}/_CommonRedist/DirectX/Jun2010/DXSETUP.exe	/silent
    $PROTON_HOME/proton waitforexitandrun $HOME/games/${game.name}/_CommonRedist/vcredist/2015/vc_redist.x64.exe	/q
    $PROTON_HOME/proton waitforexitandrun ./ConanSandbox/Binaries/Win64/ConanSandbox.exe
  ''}
''
