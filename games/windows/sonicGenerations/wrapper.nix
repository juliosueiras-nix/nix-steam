{ game, proton, lib, steamcmd, steam, writeText, steam-run, writeScript, writeScriptBin, gameFiles, lndir, steamUserInfo, protonWrapperScript, realGameLocation, ... }:

let
  sonicReg = writeText "sonic-generation.reg" ''
REGEDIT4

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Sega]

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Sega\Sonic Generations]
"locale"="en-us"
"SaveLocation"="%UserProfile%\\Saved Games\\Sonic Generations"
  '';
in writeScriptBin game.name ''
  ${
    protonWrapperScript {
      inherit game gameFiles proton lndir lib steamUserInfo steamcmd steam realGameLocation;
    }
  }

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    export WINEDLLOVERRIDES="dxgi=n" 
    export DXVK_HUD=1
    export WINEPREFIX=$PROTON_PREFIX_HOME/pfx
    export STEAM_COMPAT_DATA_PATH=$PROTON_PREFIX_HOME
    export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/steam

    # Audio fix
    export PROTON_NO_ESYNC=1 PROTON_USE_D9VK=1

    $HOME/protons/${proton.name}/proton waitforexitandrun regedit.exe ${sonicReg}
    $HOME/protons/${proton.name}/proton waitforexitandrun ./ConfigurationTool.exe	
    $HOME/protons/${proton.name}/proton waitforexitandrun ./SonicGenerations.exe	
  ''}
''
