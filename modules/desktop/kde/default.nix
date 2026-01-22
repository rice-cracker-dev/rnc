{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.home = mkIf desktop.enable {
    packages = with pkgs.kdePackages; [
      # kde apps
      dolphin
      dolphin-plugins
      gwenview
      ark

      # open with
      kservice
      kde-cli-tools

      # thumbnails
      ffmpegthumbs
      kio
      kio-extras
      kio-fuse
      kimageformats
      kdegraphics-thumbnailers
    ];

    xdg.config.files = {
      "menus/applications.menu".source = ./plasma-applications.menu;
    };
  };
}
