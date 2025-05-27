{
  lib,
  config,
  ...
}: {
  config.me.rum.programs.hyprland.settings.animation = lib.mkIf (config.configs == "fantasy") [
    "global, 0"
  ];
}
