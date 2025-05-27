{pkgs, ...}: {
  config = {
    home.packages = [pkgs.hyprpicker];
    me.rums.programs.hyprland.settings.bind = ["super shift, c, exec, hyprpicker -a"];
  };
}
