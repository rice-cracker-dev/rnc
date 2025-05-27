{
  lib,
  config,
  ...
}: {
  config.me.rum.programs.hyprland.settings.decoration = lib.mkIf (config.configs == "fantasy") {
    rounding = 0;

    dim_inactive = false;
    #dim_strength = 0.25;

    blur = {
      enabled = true;
      size = 16;
      passes = 2;

      popups = true;
    };
  };
}
