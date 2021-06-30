{ enableAdult ? false, game, linuxWrapperScript, lib, steamcmd, steam-run, writeScript, writeScriptBin, gameFiles, steamUserInfo, realGameLocation, lndir, ... }:

# Make sure you run it in a directory with no files
writeScriptBin game.name ''
  ${
    linuxWrapperScript {
      inherit game gameFiles lndir lib steamUserInfo steamcmd realGameLocation;
    }
  }

  unlink $HOME/games/${game.name}/Amorous.Game.Unix.bin.x86_64
  unlink $HOME/games/${game.name}/Amorous.Game.Unix
  unlink $HOME/games/${game.name}/FNA.dll
  cp -L ${realGameLocation}/Amorous.Game.Unix $HOME/games/${game.name}/Amorous.Game.Unix
  cp -L ${realGameLocation}/Amorous.Game.Unix.bin.x86_64 $HOME/games/${game.name}/Amorous.Game.Unix.bin.x86_64
  cp -L ${realGameLocation}/FNA.dll $HOME/games/${game.name}/
  chmod +x $HOME/games/${game.name}/Amorous.Game.Unix*

  ${if enableAdult then ''
    touch $HOME/games/${game.name}/ShowMeSomeBooty.txt 
  '' else ''
    rm $HOME/games/${game.name}/ShowMeSomeBooty.txt
  ''}

  ${steamcmd}/bin/steamcmd +login ${steamUserInfo.username} ${steamUserInfo.password} +exit
  ${steam-run}/bin/steam-run ${writeScript "fix-${game.name}" ''
    export LD_LIBRARY_PATH=${realGameLocation}/lib:${realGameLocation}/lib64:$LD_LIBRARY_PATH
    export MONO_IOMAP=case
    cd $HOME/games/${game.name}
    exec ./Amorous.Game.Unix
  ''}
''
