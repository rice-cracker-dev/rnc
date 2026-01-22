{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.home.rum.misc.gtk = mkIf desktop.enable {
    packages = with pkgs; [adw-gtk3 papirus-icon-theme];

    settings = {
      application-prefer-dark-theme = true;
      icon-theme = "Papirus-Dark";
      font-name = "Noto Sans 11";
      document-font-name = "Noto Sans 11";
      monospace-font-name = "JetBrainsMono Nerd Font 12";
      theme-name = "adw-gtk3-dark";
      color-scheme = "prefer-dark";
    };
  };
}
