{
  config,
  lib,
  self,
  pkgs,
  ...
}: let
  inherit (pkgs) writeShellApplication;
  inherit (lib) mkIf range concatMap listToAttrs concatStringsSep;
  inherit (self.lib.generators) withUWSMArgs;

  workspaceBinds = listToAttrs (concatMap (w: let
    ws = toString w;
  in [
    {
      name = "Mod+${ws}";
      value = {action = "focus-workspace ${ws}";};
    }
    {
      name = "Mod+Shift+${ws}";
      value = {action = "move-window-to-workspace ${ws}";};
    }
  ]) (range 1 9));

  flameshotExec = mode: ["flameshot" mode "-r" "-p" "$HOME/Pictures/" "|" "wl-copy"];

  cfg = config.desktop.niri;
in {
  config.home.rum.desktops.niri.binds = mkIf cfg.enable ({
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

      "Mod+h".action = "focus-column-left";
      "Mod+j".action = "focus-workspace-down";
      "Mod+k".action = "focus-workspace-up";
      "Mod+l".action = "focus-column-right";

      "Mod+Shift+h".action = "swap-window-left";
      "Mod+Shift+j".action = "move-column-to-workspace-down";
      "Mod+Shift+k".action = "move-column-to-workspace-up";
      "Mod+Shift+l".action = "swap-window-right";

      "Mod+w".action = "close-window";
      "Mod+m".spawn = ["uwsm" "stop"];
      "Mod+f".action = "fullscreen-window";
      "Mod+v".action = "toggle-window-floating";

      "XF86AudioRaiseVolume".spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" "-l" "1"];
      "XF86AudioLowerVolume".spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" "-l" "1"];
      "XF86AudioMute".spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];

      "Print".spawn = flameshotExec "screen";
      "Ctrl+Print".spawn = flameshotExec "gui";

      # apps
      "Mod+D".spawn = withUWSMArgs ["fuzzel"];
      "Mod+Return".spawn = withUWSMArgs ["kitty"];
      "Mod+Shift+C".spawn = withUWSMArgs ["hyprpicker" "-a"];
    }
    // workspaceBinds);
}
