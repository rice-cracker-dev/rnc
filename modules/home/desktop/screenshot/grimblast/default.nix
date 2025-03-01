{pkgs, ...}: {
  home.packages = [pkgs.grimblast];

  wayland.windowManager.hyprland.settings.bind = [
    ", print, exec, ${pkgs.grimblast}/bin/grimblast copysave screen"
    "ctrl, print, exec, ${pkgs.grimblast}/bin/grimblast copysave area"
    "alt, print, exec, ${pkgs.grimblast}/bin/grimblast save area - | ${pkgs.satty}/bin/satty -f -"
    "shift, print, exec, ${pkgs.grimblast}/bin/grimblast copysave active"
  ];
}
