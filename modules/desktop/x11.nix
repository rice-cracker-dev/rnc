{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    services.xserver.enable = true;
  };
}
