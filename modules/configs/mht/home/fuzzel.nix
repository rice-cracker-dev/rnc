{
  riceLib,
  config,
  lib,
  ...
}: let
  inherit (riceLib.generators) toUWSM;
  inherit (lib) mkIf;
in {
  config.me.rum.programs = mkIf (config.configs == "mht") {
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
