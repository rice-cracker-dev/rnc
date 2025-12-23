{
  pkgs,
  config,
  lib,
  ...
}: {
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = lib.mkIf config.enableDesktopModules {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs.qt6Packages; [
        fcitx5-unikey
      ];
      fcitx5.waylandFrontend = true;
    };
  };
}
