{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    hardware.opentabletdriver.enable = true;
  };
}
