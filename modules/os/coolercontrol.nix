{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    programs.coolercontrol.enable = true;
  };
}
