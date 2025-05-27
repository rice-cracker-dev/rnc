{
  inputs,
  lib,
  config,
  ...
}: let
  themeFile = "${inputs.catppuccin-kitty}/themes/macchiato.conf";
in {
  config.home.kitty = lib.mkIf (config.configs == "fantasy") {
    enable = true;

    inherit themeFile;

    settings = {
      background = "#000000";
      background_opacity = 0.75;

      font_family = "Monocraft";
    };
  };
}
