{ name, appId, depotId, manifestId, platform ? "linux", extraAction ? "" }: {
  inherit name appId platform depotId manifestId extraAction;
}
