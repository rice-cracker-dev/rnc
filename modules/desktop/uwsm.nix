{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    programs.uwsm.enable = true;
    services.xserver.displayManager.startx.enable = true;
  };
}
