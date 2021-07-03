{
  description = "Nix-Steam, a nix system for steam games";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/3b6c3bee9174dfe56fd0e586449457467abe7116";
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

      overlays = [(final: prev: let
        steam = (prev.steam.override {
          extraLibraries = pkgs: [ pkgs.cacert ];
        });
      in {
        steam-run = steam.run;
        steam = steam;
        steamctl = prev.callPackage ./deps {
          pythonPackages = prev.python38Packages;
        };
      })];
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
        buildInputs = [ 
          pkgs.nixfmt
          pkgs.steamcmd
          pkgs.steamctl
          
        ];
      };
    });
  }
