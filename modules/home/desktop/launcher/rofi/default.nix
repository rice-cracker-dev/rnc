{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  wayland.windowManager.hyprland.settings.bind = [
    "super, d, exec, rofi -show drun -run-command \"uwsm app -- {cmd}\""
  ];
}
