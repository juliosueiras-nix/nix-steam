let 
  defaultNix = (import ../default.nix {}).defaultNix;
  steamStore = (defaultNix.makeSteamStore.x86_64-linux {
    username = "<>";
    password = "<>";
    useGuardFiles = false;
  });
in steamStore.linux.Portal2
