{
  description = "Nix-Steam, a nix system for steam games";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/3b6c3bee9174dfe56fd0e586449457467abe7116";
    #nixUnstable.url = "github:nixos/nix/7746cb13dc4e644c9792b3e3666cd49635d694e0";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      config = { 
        allowUnfree = true;
      };

      #overlays = [
      #  (fin: prev: {
      #    nixUnstable = nixUnstable.defaultPackage.x86_64-linux;
      #  })
      #];
    };
  in {
    helperLib = pkgs.callPackage ./lib/top-level.nix {
      nixpkgsSource = nixpkgs;
    };
    makeSteamStore = steamUserInfo: pkgs.callPackage ./games/top-level.nix {
      inherit steamUserInfo;
      helperLib = self.helperLib."${system}";
    };

    devShell =
      pkgs.mkShell { 
        NIX_PATH = "nixpkgs=${nixpkgs}";
        DOCKER_HOST = "unix:///var/run/podman/podman.sock";
        buildInputs = [ 
          pkgs.arion
          pkgs.nixfmt
          pkgs.ripgrep
          pkgs.steamcmd
          pkgs.depotdownloader
          pkgs.protontricks
        ];
      };
    });
  }
