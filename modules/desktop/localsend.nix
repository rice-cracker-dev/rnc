{
  config,
  lib,
  ...
}: {
  config.programs.localsend = lib.mkIf config.enableDesktopModules {
    enable = true;
    openFirewall = true;
  };
}
