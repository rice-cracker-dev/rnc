{
  lib,
  config,
  ...
}: {
  config.me.rum.programs.hyprland.settings.misc = lib.mkIf (config.configs == "fantasy") {
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
  };
}
