{ callPackage, steamUserInfo, helperLib }:

with helperLib;

{
  proton_6_3 = import ./6.3 { inherit steamUserInfo gameInfo gameFileInfo makeSteamGame; };
  proton_6_10_ge = callPackage ./6.10-GE {};
}
