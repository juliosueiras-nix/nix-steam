{ steamUserInfo, helperLib, proton }:

with helperLib;

let
  normalList = { inherit steamUserInfo gameInfo proton gameFileInfo makeSteamGame; };
in {
  SonicGenerations = import ./sonicGenerations normalList;
  JustCause = import ./justCause normalList;
  SleepingDogs = import ./sleepingDogs normalList;
  RocketLeague = import ./rocketLeague normalList;
  Warframe = import ./warframe normalList;
  UminekoGoldenFantasia = import ./uminekoGoldenFantasia normalList;
  Payday = import ./payday normalList;
  ProjectWingman = import ./projectWingman normalList;
  SteinsGate = import ./steinsGate normalList;
  SteinsGate0 = import ./steinsGate0 normalList;
  SteinsGateElite = import ./steinsGateElite normalList;
  SteinsGateLBP = import ./steinsGateLBP normalList;
  AlanWake = import ./alanWake normalList;
  ThereIsNoGame = import ./thereIsNoGame normalList;
  BleachBraveSouls = import ./bleachBraveSouls normalList;
  Brawlhalla = import ./brawlhalla normalList;
}
