{riceLib, ...}: let
  inherit (riceLib.generators) toUWSM;
in {
  config.me.rum.programs = {
    fuzzel = {
      enable = true;
      settings = {
        main.launch-prefix = "uwsm app -- ";
      };
    };

    hyprland.settings.bind = [
      "super, d, exec, ${toUWSM "fuzzel"}"
    ];
  };
}
