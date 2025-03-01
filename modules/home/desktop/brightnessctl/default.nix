{pkgs, ...}: {
  home.packages = [pkgs.brightnessctl];

  wayland.windowManager.hyprland.settings.binde = [
    ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%+"
    ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
  ];
}
