{pkgs, ...}: {
  config.me = {
    packages = [pkgs.hyprpicker];
    rums.programs.hyprland.settings.bind = ["super shift, c, exec, hyprpicker -a"];
  };
}
