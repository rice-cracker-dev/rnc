{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    services.mullvad-vpn.enable = true;
  };
}
