{
  config,
  lib,
  pins,
  ...
}: let
  inherit (lib) mkIf genAttrs' nameValuePair;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    home.rum.programs.kitty = {
      enable = true;

      theme =
        genAttrs' ["no-preference" "dark" "light"]
        (s: nameValuePair s "${pins.catppuccin-kitty}/themes/macchiato.conf");

      settings = {
        background_opacity = 0.8;

        font_family = "JetBrainsMono Nerd Font";
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";

        map = [
          "ctrl+tab"
          "ctrl+shift+tab"
          "ctrl+shift+h previous_tab"
          "ctrl+shift+l next_tab"
        ];
      };
    };

    desktop.uwsm.defaultEnv.TERMINAL = "kitty";
  };
}
