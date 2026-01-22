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
    home.rum.misc.gtk = {
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

    desktop.uwsm.defaultEnv.GTK_THEME = "adw-gtk3-dark:dark";

    programs.dconf.profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            gtk-theme = "adw-gtk3-dark";
            icon-theme = "Papirus-Dark";
            font-name = "Noto Sans 11";
            document-font-name = "Noto Sans 11";
            monospace-font-name = "JetBrainsMono Nerd Font 12";
            color-scheme = "prefer-dark";
            gtk-enable-primary-paste = false; # disable middle click paste
          };
          "org/gnome/desktop/wm/preferences" = {
            # hide all title bar buttons on gtk apps
            button-layout = ":";
          };
        };
      }
    ];
  };
}
