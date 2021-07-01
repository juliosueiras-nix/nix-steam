{ stdenv, nixpkgsSource, ruby, writeText, jq, nixUnstable, lib, cacert, steamctl, ...  }:

{ game, steamUserInfo, ... }:

let
  generateJSON = writeText "generate-manifest-json" ''
    require 'json'

    result = []

    File.read(ARGV[0]).split("\n").map {|line| 
      matches = line.match(/(.*) - size:(.*) sha1:(.*)/)
      if matches
        fileName = matches.captures[0].gsub(/\\/,'/')
        fileSize = matches.captures[1].gsub(/,/, ${"'"}').to_i
        sha1Checksum = matches.captures[2]
        result.append({ fileName: fileName, fileSize: fileSize, sha1Checksum: sha1Checksum })
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
    steamctl
  ];

  buildCommand = ''
    export HOME=$PWD

    ${lib.optionalString steamUserInfo.useGuardFiles ''
      mkdir -p $HOME/.local/share/steamctl
      cp -r ${steamUserInfo.steamctlFiles}/* $HOME/.local/share/steamctl/
      chmod -R +rw $HOME/.local/share/steamctl/
    ''}

    steamctl --user ${steamUserInfo.username} --password_file ${steamUserInfo.passwordFile} depot list -os ${game.platform}  -a ${game.appId} -d ${game.depotId} -m ${game.manifestId} --long --skip-licenses > manifest.txt 

    ${ruby}/bin/ruby ${generateJSON} manifest.txt > manifest.json
    rm manifest.txt

    steamctl --user ${steamUserInfo.username} --password_file test depot download -os ${game.platform}  -a ${game.appId} -d ${game.depotId} -m ${game.manifestId} -o $PWD/game --skip-licenses 

    ${game.extraAction}
  
    cd game 
    mkdir -p ${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/
    cat ../manifest.json | jq -r '.[].fileName' | sed -e "s/'/\\\'/g" | xargs -I % sh -c 'echo "Adding % to ${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}"; mkdir -p "${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/$(dirname "%")"; chmod g+rw "${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/$(dirname "%")"; mv "%" "${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/%"; chmod g+rw "${steamUserInfo.targetStore}/${game.platform}/${game.mainGameName}/%"'

    cd ..
    rm -r game

    mkdir -p $out/${game.name}
    mv manifest.json $out/${game.name}/manifest.json
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
}
