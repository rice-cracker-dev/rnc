{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    services.mullvad-vpn.enable = true;
  };
}
