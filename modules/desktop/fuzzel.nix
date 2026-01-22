{
  config,
  lib,
  pins,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.home.rum.programs.fuzzel = mkIf desktop.enable {
    enable = true;
    settings = {
      main = {
        include = "${pins.catppuccin-fuzzel}/themes/catppuccin-macchiato/mauve.ini";
        launch-prefix = "uwsm app -- ";
      };
    };
  };
}
