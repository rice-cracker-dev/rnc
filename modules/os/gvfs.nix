{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    services.gvfs.enable = true;
  };
}
