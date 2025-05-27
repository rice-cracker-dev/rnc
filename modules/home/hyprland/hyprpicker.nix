{pkgs, ...}: {
  config.me = {
    packages = [pkgs.hyprpicker];
    rum.programs.hyprland.settings.bind = ["super shift, c, exec, hyprpicker -a"];
  };
}
