{pkgs, ...}: {
  config.home = {
    packages = [pkgs.kitty];

    rum.programs.hyprland.settings.bind = [
      "super, return, exec, kitty"
    ];
  };
}
