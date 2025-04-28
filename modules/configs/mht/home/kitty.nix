{inputs, ...}: let
  themeConf = "${inputs.catppuccin-kitty}/themes/macchiato.conf";
in {
  config.home.kitty = {
    enable = true;

    includes = [themeConf];

    settings = {
      background = "#000000";
      background_opacity = 0.75;
    };
  };
}
