{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
