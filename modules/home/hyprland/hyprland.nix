{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    me.rum.desktops.hyprland.enable = true;
  };
}
