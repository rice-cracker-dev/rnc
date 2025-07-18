{
  config,
  lib,
  ...
}: {
  config.me.rum.desktops.hyprland.settings.general = lib.mkIf (config.configs == "mht") {
    border_size = 1;

    "col.inactive_border" = "rgb(363a4f)";
    "col.active_border" = "rgb(c6a0f6)";

    gaps_in = 0;
    gaps_out = 8;
  };
}
