{
  lib,
  config,
  ...
}: {
  config.me.rum.desktops.hyprland.settings.misc = lib.mkIf (config.configs == "mht") {
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
  };
}
