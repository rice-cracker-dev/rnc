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
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-bamboo
      ];
      fcitx5.waylandFrontend = true;
    };
  };
}
