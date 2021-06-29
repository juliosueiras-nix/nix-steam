{ steamUserInfo, helperLib }:

with helperLib;

{
  Antichamber = import ./antichamber { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
  Amorous = import ./amorous { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
  HigurashiCh6 = import ./higurashiCh6 { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
  Helltaker = import ./helltaker { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
  UminekoQuestion = import ./uminekoQuestion { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
  UminekoAnswer = import ./uminekoAnswer { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
  Portal2 = import ./portal2 { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
}
