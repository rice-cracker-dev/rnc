# env settings taken from
# https://gitlab.com/fazzi/nixohess/-/blob/main/modules/programs/hyprland/env.nix
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.desktop.hyprland;
in {
  config.desktop.uwsm = mkIf cfg.enable {
    defaultEnv = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";

      # fix java bug on tiling wm's / compositors
      _JAVA_AWT_WM_NONREPARENTING = "1";
      # enable java anti aliasing
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";

      # don't use libdecor as it's a little borken
      LIBDECOR_PLUGIN_DIR = "nope";
    };
  };
}
