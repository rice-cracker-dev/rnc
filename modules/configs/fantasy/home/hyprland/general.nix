{
  config,
  lib,
  ...
}: {
  config.me.rum.programs.hyprland.settings.general = lib.mkIf (config.configs == "fantasy") {
    border_size = 1;

    "col.inactive_border" = "rgb(363a4f)";
    "col.active_border" = "rgb(c6a0f6)";

    gaps_in = 8;
    gaps_out = 8;
  };
}
