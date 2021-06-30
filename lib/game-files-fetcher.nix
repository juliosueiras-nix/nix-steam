{ stdenv, nixpkgsSource, ruby, writeText, jq, nixUnstable, lib, cacert, depotdownloader, ...  }:

{ game, steamUserInfo, ... }:

let
  generateJSON = writeText "generate-manifest-json" ''
    require 'json'

    lineCount = 0

    fileName = ""
    fileSize = 0
    md5Checksum = ""

    result = []

    File.read(ARGV[0]).split("\n").map {|line|
      case lineCount
      when 0
        fileName = line
        lineCount+=1
      when 1
        fileSize = line.to_i
        lineCount+=1
      when 2
        md5Checksum = line.gsub(/\t/, ${"'"}').downcase
        result.append({ fileName: fileName, fileSize: fileSize, md5Checksum: md5Checksum })
        lineCount=0
      end
    }

    puts result.to_json
  '';
in stdenv.mkDerivation {
  name = "${game.name}-links";

  buildInputs = [
    jq
    nixUnstable
    cacert
    depotdownloader
  ];

  buildCommand = ''
    export HOME=$PWD
    ${lib.optionalString steamUserInfo.useGuardFiles ''
      mkdir -p $HOME/.local/share/IsolatedStorage
      cp -r ${steamUserInfo.depotdownloaderStorage}/* $HOME/.local/share/IsolatedStorage/
      chmod -R +rw $HOME/.local/share/IsolatedStorage/
    ''}
    depotdownloader -os ${game.platform} -username ${steamUserInfo.username} -password ${steamUserInfo.password} -dir $PWD/game -app ${game.appId} -depot ${game.depotId} -manifest-only -manifest ${game.manifestId} -max-downloads 20 
    rm -r game/.DepotDownloader

    sed -i '1,2d' game/manifest*
    ${ruby}/bin/ruby ${generateJSON} game/manifest* > manifest.json
    rm -r game

    depotdownloader -os ${game.platform} -username ${steamUserInfo.username} -password ${steamUserInfo.password} -dir $PWD/game -app ${game.appId} -depot ${game.depotId} -manifest ${game.manifestId} -max-downloads 20 
    rm -r game/.DepotDownloader

    ${game.extraAction}
  
    cd game 
    mkdir -p ${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/
    cat ../manifest.json | jq -r '.[].fileName' | xargs -I % sh -c 'mkdir -p "${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/$(dirname "%")"; chmod g+rw "${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/$(dirname "%")"; mv "%" "${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/%"; chmod g+rw "${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/%"'

    cd ..
    rm -r game

    mkdir -p $out/${game.name}
    mv manifest.json $out/${game.name}/manifest.json
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
}
