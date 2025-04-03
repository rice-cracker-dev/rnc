{
  pkgs,
  config,
  lib,
  ...
}: {
  options.rofi = {
    enable = lib.mkEnableOption "enable rofi";
  };

  config = lib.mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    wayland.windowManager.hyprland.settings.bind = [
      "super, d, exec, rofi -show drun -run-command \"uwsm app -- {cmd}\""
    ];
  };
}
