{ steamUserInfo, helperLib }:

with helperLib;

let
  normalList = { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
in {
  Antichamber = import ./antichamber normalList;
  Amorous = import ./amorous normalList;
  HigurashiCh6 = import ./higurashiCh6 normalList;
  Helltaker = import ./helltaker normalList;
  UminekoQuestion = import ./uminekoQuestion normalList;
  UminekoAnswer = import ./uminekoAnswer normalList;
  Portal2 = import ./portal2 normalList;
  Payday2 = import ./payday2 normalList;
}
