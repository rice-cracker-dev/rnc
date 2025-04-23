{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
  };

  wayland.windowManager.hyprland.settings.bind = [
    "super, return, exec, ${pkgs.kitty}/bin/kitty"
  ];
}
