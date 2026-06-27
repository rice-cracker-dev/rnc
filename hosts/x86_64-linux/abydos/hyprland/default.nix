{lib, ...}: let
  inherit (lib.rnc.dag) entryAfter;
in {
  config.desktop.hyprland = {
    monitor = [
      {
        output = "eDP-1";
        mode = "1920x1080@144";
        position = "0x0";
        scale = 1;
      }
    ];

    luaConfig.touchpad-toggle = entryAfter ["bind"] ./toggle-touchpad.lua;
  };
}
