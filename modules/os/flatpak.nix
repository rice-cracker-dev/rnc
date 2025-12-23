{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    services.flatpak.enable = true;
  };
}
