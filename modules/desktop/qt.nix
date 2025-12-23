{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    qt.enable = true;
    qt.platformTheme = "qt5ct";

    environment.systemPackages = with pkgs; [qt6.qtdeclarative qt6.qtmultimedia kdePackages.qt6ct];
  };
}
