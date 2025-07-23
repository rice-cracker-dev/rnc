{
  inputs,
  lib,
  config,
  ...
}: let
  themeFile = "${inputs.catppuccin-kitty}/themes/macchiato.conf";
in {
  config.home.kitty = lib.mkIf (config.configs == "mht") {
    enable = true;

    inherit themeFile;

    settings = {
      background = "#000000";
      background_opacity = 0.75;

      font_family = "JetBrains Mono";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
    };
  };
}
