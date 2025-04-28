{
  inputs,
  config,
  lib,
  ...
}: let
  wallpaperPath = "${inputs.self}/wallpapers/background1.jpg";
in {
  config.home.swww = lib.mkIf (config.configs == "mht") {
    enable = true;
    inherit wallpaperPath;
  };
}
