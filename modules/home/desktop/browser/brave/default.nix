{pkgs, ...}: {
  home.packages = [pkgs.brave];

  wayland.windowManager.hyprland.settings.bind = [
    "super, w, exec, ${pkgs.brave}/bin/brave"
  ];
}
