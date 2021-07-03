{ game, lib, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, symlinkJoin, lndir, linuxWrapperScript, realGameLocation, steamcmdLogin, ... }:

writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  unlink $HOME/games/${game.name}/Shenzhen
  cp -L ${realGameLocation}/Shenzhen $HOME/games/${game.name}/Shenzhen

  unlink $HOME/games/${game.name}/Content/textures/*
  cp -L -r ${realGameLocation}/Content/textures/* $HOME/games/${game.name}/Content/textures/

  unlink $HOME/games/${game.name}/PackedContent/fonts/*
  cp -L -r ${realGameLocation}/PackedContent/fonts/* $HOME/games/${game.name}/PackedContent/fonts/

  rm $HOME/games/${game.name}/Shenzhen.bin.x86_64
  cp -L ${realGameLocation}/Shenzhen.bin.x86_64 $HOME/games/${game.name}/Shenzhen.bin.x86_64


  chmod +rwx $HOME/games/${game.name}/Shenzhen
  chmod +rwx $HOME/games/${game.name}/Shenzhen.bin.x86_64

  ${steamcmdLogin { inherit steamUserInfo steamcmd; }}
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    cd $HOME/games/${game.name}
    exec ./Shenzhen
  ''}
''
