{
  lib,
  config,
  ...
}: {
  config.me.rum.desktops.hyprland.settings.decoration = lib.mkIf (config.configs == "mht") {
    rounding = 0;

    dim_inactive = false;
    #dim_strength = 0.25;

    blur = {
      enabled = true;
      size = 16;
      passes = 4;
      noise = 0.05;
      popups = true;
    };
  };
}
