{pkgs, ...}: {
  config.me = {
    packages = [pkgs.hyprpicker];
    rum.desktops.hyprland.settings.bind = ["super shift, c, exec, hyprpicker -a"];
  };
}
