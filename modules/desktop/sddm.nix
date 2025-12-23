{
  config,
  lib,
  ...
}: {
  config.services.displayManager.sddm = lib.mkIf config.enableDesktopModules {
    enable = true;
    wayland.enable = true;
  };
}
