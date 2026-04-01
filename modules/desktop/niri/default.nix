{
  config,
  lib,
  self,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (self.lib.generators) withUWSMArgs;
  # inherit (config) desktop;

  cfg = config.desktop.niri;
in {
  options.desktop.niri = {
    enable = mkEnableOption "niri" // {default = false;};
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
      config = {
        common = {
          default = [
            "gnome"
          ];
        };
      };
    };

    programs = {
      niri.enable = true;

      uwsm.waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };
    };

    home.rum.desktops.niri = {
      enable = true;

      binds = {
        # Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        # Mod+WheelScrollUp   cooldown-ms=150 { focus-workspace-up; }
        # Mod+WheelScrollRight                { focus-column-right; }
        # Mod+WheelScrollLeft                 { focus-column-left; }
        "Mod+WheelScrollDown" = {
          parameters.cooldown-ms = 150;
          action = "focus-workspace-down";
        };

        "Mod+WheelScrollUp" = {
          parameters.cooldown-ms = 150;
          action = "focus-workspace-up";
        };

        "Mod+WheelScrollRight".action = "focus-column-right";
        "Mod+WheelScrollLeft".action = "focus-column-left";

        "Mod+W".action = "close-window";
        "Mod+m".spawn = ["uwsm" "stop"];

        "XF86AudioRaiseVolume".spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" "-l" "1"];
        "XF86AudioLowerVolume".spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" "-l" "1"];
        "XF86AudioMute".spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];

        # apps
        "Mod+D".spawn = withUWSMArgs ["fuzzel"];
        "Mod+Return".spawn = withUWSMArgs ["kitty"];
        "Mod+Shift+C".spawn = withUWSMArgs ["hyprpicker" "-a"];
      };
    };
  };
}
