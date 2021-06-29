{ stdenv, nixpkgsSource, writeText, jq, nixUnstable, lib, cacert, depotdownloader, ...  }:

{ game, steamUserInfo, ... }:

let
  recursiveBuildDef = writeText "${game.name}-nested-build" ''
with import <nixpkgs> {
  config = { 
    allowUnfree = true;
  };
};
stdenv.mkDerivation {
    name = "${game.name}-links";
    requiredSystemFeatures = [ "recursive-nix" ];
    __contentAddressed = true;

    buildInputs = [
      jq
      (lib.getDev nixUnstable)
      cacert
      depotdownloader
    ];

    buildCommand = '''
      export HOME=$PWD
      ${lib.optionalString steamUserInfo.useGuardFiles ''
        mkdir -p $HOME/.local/share/IsolatedStorage
        cp -r ${steamUserInfo.depotdownloaderStorage}/* $HOME/.local/share/IsolatedStorage/
        chmod -R +rw $HOME/.local/share/IsolatedStorage/
      ''}

      depotdownloader -os ${game.platform} -username ${steamUserInfo.username} -password ${steamUserInfo.password} -dir $PWD/game -app ${game.appId} -depot ${game.depotId} -manifest ${game.manifestId} -max-downloads 20
      rm -r game/.DepotDownloader

      ${game.extraAction}
    
      mkdir -p $out
      cd game

      find * -type f -exec echo "Adding {} to store" \;  -exec bash -c 'echo "{ \"name\": \"{}\", \"path\": \"$(file="{}"; nix store add-file --name $(basename "{}" | sed "s/[^a-zA-Z]*//g") "$file")\" }"  >> $out/paths.json' \;
      cat $out/paths.json | jq -s '.' > temp
      mv temp $out/paths.json
    ''';

    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  }
'';

  nestedLinkFarm = writeText "${game.name}-nested-build" ''
with import <nixpkgs> {
  config = { 
    allowUnfree = true;
  };
};

{ currPath }: linkFarm "${game.name}-linkfarm" (builtins.fromJSON (builtins.readFile "''${currPath}/paths.json"))
'';
in stdenv.mkDerivation {
  name = "${game.name}-links";

  requiredSystemFeatures = [ "recursive-nix" ];

  buildInputs = [
    jq
    nixUnstable
    cacert
    depotdownloader
  ];

  NIX_PATH = "nixpkgs=${nixpkgsSource}";
  buildCommand = ''
    nix-build ${recursiveBuildDef}
    nix-build --argstr currPath $(realpath ./result) ${nestedLinkFarm} 
    ln -s $(realpath ./result) $out
    echo $out
  '';

  __contentAddressed = false;
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
}
