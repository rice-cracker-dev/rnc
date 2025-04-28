{inputs, ...}: let
  wallpaperPath = "${inputs.self}/wallpapers/background1.jpg";
in {
  config.home.swww = {
    enable = true;
    inherit wallpaperPath;
  };
}
