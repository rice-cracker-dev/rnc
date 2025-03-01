{pkgs, ...}: {
  home.packages = [pkgs.rofi-wayland];

  wayland.windowManager.hyprland.settings.bind = [
    "super, d, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"
  ];
}
