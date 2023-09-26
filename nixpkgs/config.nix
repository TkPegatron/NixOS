{ ... }: {
  config.allowUnfree = true;
  #config.allowUnfreePredicate =
  #  pkg: builtins.elem ( lib.getName pkg ) [
  #    "discord" "vivaldi" "widevine-cdm" "vscode" "steam-original" "steam"
  #];
}
