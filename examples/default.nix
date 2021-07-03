let 
  defaultNix = (import ../default.nix {}).defaultNix;
  steamStore = (defaultNix.makeSteamStore.x86_64-linux {
    username = "<>";
    targetStore = "<path-to-target-store>";
    outputStore = "<path-to-output-store>";
    passwordFile = "<path-to-password>";
    useGuardFiles = false;
  });
in steamStore.linux.Portal2
