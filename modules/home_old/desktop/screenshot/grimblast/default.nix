{pkgs, ...}: {
  home.packages = [pkgs.grimblast];

  wayland.windowManager.hyprland.settings.bind = [
    ", print, exec, grimblast copysave screen"
    "ctrl, print, exec, grimblast copysave area"
    "alt, print, exec, grimblast save area - | satty -f -"
    "shift, print, exec, grimblast copysave active"
  ];
}
