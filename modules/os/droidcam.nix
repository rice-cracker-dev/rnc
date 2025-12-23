{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    programs.droidcam.enable = true;
  };
}
