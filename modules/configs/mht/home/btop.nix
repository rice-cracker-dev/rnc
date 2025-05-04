{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.configs;
  themeFile = "${inputs.catppuccin-btop}/themes/catppuccin_macchiato.theme";
in {
  config.home.btop = mkIf (cfg == "mht") {
    enable = true;

    themes.catppuccin-macchiato = themeFile;

    settings = {
      color_theme = "catppuccin-macchiato";
      theme_background = false;
    };
  };
}
