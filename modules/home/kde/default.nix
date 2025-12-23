{
  pkgs,
  config,
  lib,
  ...
}: {
  config.me = lib.mkIf config.enableDesktopModules {
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

    files = {
      ".config/menus/applications.menu".source = ./plasma-applications.menu;
    };
  };
}
