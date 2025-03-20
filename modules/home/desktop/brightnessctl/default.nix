{pkgs, ...}: {
  home.packages = [pkgs.brightnessctl];

  wayland.windowManager.hyprland.settings.binde = [
    ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
    ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
  ];
}
