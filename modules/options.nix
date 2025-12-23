{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.enableDesktopModules = mkEnableOption "desktop modules" // {default = true;};
}
