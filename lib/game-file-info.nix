{ name, appId, depotId, mainGameName, manifestId, platform ? "linux", extraAction ? "" }: {
  inherit name appId platform depotId manifestId extraAction mainGameName;
}
