# Nix Steam System

<video src="http://techslides.com/demos/sample-videos/small.mp4" type="video/mp4">Hello</video>

## What is Nix-Steam

nix-steam is a nix repo that contains steam games in both Linux and Windows(via proton) to install and run declaratively in Linux distros(both nixos, and non-nixos)

**It is experimental and constant improvement will be happening**

## Requirements

- it needs to support cgroup due to steam-run

- it need sandbox to be off, hopefully in the future we can enable sandbox for everything

## Note

this can be run under non-nixos, same restriction apply to the above

## Logging in for Steam

### No SteamGuard

without steamguard it's pretty straightforward

```nix
let 
  defaultNix = (import ../default.nix {}).defaultNix;
in (defaultNix.makeSteamStore.x86_64-linux {
  username = "<username>";

  # Both of these need to be created beforehand, and targetStore need a a+rwx permission(only the dir itself)
  outputStore = "<path-to-output-store>"; # this is where you will store the prefixes and various stuff
  targetStore = "<path-to-target-store>"; # this is where you will store the games 

  passwordFile = "<path-to-a-password-file>";
  useGuardFiles = false;
})
```

### With SteamGuard

with steamguard enabled, you will need to get two file sets(one time per machine)

1. files from running a basic steamcmd +login 

```
$HOME/.steam/steam/config/config.vdf
$HOME/.steam/steam/config/libraryfolders.vdf
$HOME/.steam/steam/ssfn*
```

2. folder from running a basic steamctl depot info or apps info

```
$HOME/.local/share/steamctl
```

after you have these files, you can login via this

```nix
let 
  defaultNix = (import ../nix-steam/default.nix {}).defaultNix;
in (defaultNix.makeSteamStore.x86_64-linux {
  username = "<username>";

  # Both of these need to be created beforehand, and targetStore need a a+rwx permission(only the dir itself)
  outputStore = "<path-to-output-store>"; # this is where you will store the prefixes and various stuff
  targetStore = "<path-to-target-store>"; # this is where you will store the games 

  passwordFile = "<path-to-a-password-file>";
  useGuardFiles = true;
  cachedFileDir = <path-to>/steamFiles;
  steamctlFiles = <path-to>/steamctlFiles;
})
```

## Adding a Game(Linux/Windows)

### Step 1: SteamDB is your friend

Steam games are made from single/multiple depots, this normally happens in the background for both normal steam downloads and steamcmd +app_update command, however, since we want locking, we have to construct the games ourself.

#### Find info of game and depot

we will use [Helltaker](https://steamdb.info/app/1289310) as a example

first we need to find out what depots it has, which can be found under the [Depots](https://steamdb.info/app/1289310/depots/) section, where there are two depots that we need(logically), `Helltaker Content Linux` and `Helltaker Local`.

we will have the following template

```nix
{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Helltaker";
in makeSteamGame {
  inherit steamUserInfo;

  game = gameInfo {
    name = mainGameName;
    appId = "1289310"; # You can findout the appId from the steamdb page
  };

  gameFiles = [
  ];

  drvPath = ./wrapper.nix;

  # proton = proton.<version> # This option is only for Windows game
}
```

#### Construct Depots

the `gameFiles` param accepts either a list or a single entry for games with a singular or multiple depots

now lets construct with depots

both depotid and manifestid can be found on their own page

- [Helltaker Content Linux](https://steamdb.info/depot/1289314/) DepotId: 1289314, ManifestId: 8723838119065609357
- [Helltaker Local](https://steamdb.info/depot/1289315/) DepotId: 1289315, ManifestId: 8723838119065609357

```nix
{ makeSteamGame, steamUserInfo, gameInfo, gameFileInfo }:

let
  mainGameName = "Helltaker";
in makeSteamGame {
  inherit steamUserInfo;


  game = gameInfo {
    name = mainGameName;
    appId = "1289310";
  };

  gameFiles = [
    (gameFileInfo {
      inherit mainGameName;
      name = "Helltaker";
      appId = "1289310"; # same AppId from above
      depotId = "1289314";
      manifestId = "8723838119065609357";
      # platform = "windows"; # This option is only for Windows game
    })

    (gameFileInfo {
      inherit mainGameName;
      name = "Helltaker-Local";
      appId = "1289310"; # same AppId from above
      depotId = "1289315";
      manifestId = "6394422377711576735";
      # platform = "windows"; # This option is only for Windows game
    })
  ];

  drvPath = ./wrapper.nix;
  # proton = proton.<version> # This option is only for Windows game
}
```

#### Build the Game

now we are ready to build the game

run it with `nix-build --max-jobs 1`, to build the game

### Step 2: Wrapper time

for most games, the wrapper follows a similar template to these

the information about the launcher can be found under the [Configuration](https://steamdb.info/app/1289310/config/) section

**Windows uses protonWrapperScript and Linux uses linuxWrapperScript**

#### Linux Games

```nix
{ game, lib, steamcmd, steam-run-native, writeScript, writeScriptBin, gameFiles, steamUserInfo, lndir, ... }:


writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  rm $HOME/games/${game.name}/<binary>	
  cp -L ${gameFiles}/<binary> $HOME/games/${game.name}/
  chmod +rwx $HOME/games/${game.name}/<binary>

  ${steam-run-native}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}/
    exec ./<binary>
  ''}
''
```

#### Windows Games

```nix
{ game, proton, lib, steamcmd, steam, steam-run, writeScript, writeScriptBin, gameFiles, lndir, steamUserInfo, protonWrapperScript, ... }:

writeScriptBin game.name ''
  ${
    protonWrapperScript {
      inherit game gameFiles proton lndir lib steamUserInfo steamcmd steam;
    }
  }

  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    export WINEDLLOVERRIDES="dxgi=n" 
    export DXVK_HUD=1
    export WINEPREFIX=$HOME/.proton/pfx
    export STEAM_COMPAT_DATA_PATH=$HOME/.proton
    export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/steam

    $PROTON_HOME/proton waitforexitandrun ./<exe>	
  ''}
''
```

Of course, you can do anything you want in the wrapper for game-specific fixes or feature settings

### Step 3: Add it to packages list

Lastly, make sure you have the new game under the platform's top-level.nix

## Caveats

- right now the password is plaintext in the running process, is not in the scripts, but would shown if you do a `ps` command

- some games, especially multiplayer/mmo games will use the `targetStore` directly due to the update nature

- due to steam restrictions, it needs to be run with --max-jobs 1
