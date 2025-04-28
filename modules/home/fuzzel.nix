{riceLib, ...}: let
  inherit (riceLib.uwsm) useUWSM;
in {
  config.me.rum.programs = {
    fuzzel = {
      enable = true;
      settings = {
        main.launch-prefix = "uwsm app -- ";
      };
    };

    hyprland.settings.bind = [
      "super, d, exec, ${useUWSM "fuzzel"}"
    ];
  };
}
