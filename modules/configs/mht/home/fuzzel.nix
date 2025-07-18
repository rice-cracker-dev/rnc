{
  riceLib,
  config,
  lib,
  ...
}: let
  inherit (riceLib.generators) toUWSM;
  inherit (lib) mkIf;
in {
  config.me.rum = mkIf (config.configs == "mht") {
    programs.fuzzel = {
      enable = true;
      settings = {
        main.launch-prefix = "uwsm app -- ";
      };
    };

    desktops.hyprland.settings.bind = [
      "super, d, exec, ${toUWSM "fuzzel"}"
    ];
  };
}
