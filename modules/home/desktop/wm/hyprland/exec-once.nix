{pkgs, ...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.fcitx5}/bin/fcitx5 -d -r"
  ];
}
