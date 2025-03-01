{pkgs, config, lib, ...}: {
  options.mpvpaper = {
    enable = lib.mkEnableOption "enable mpvpaper";
    
    wallpaperPath = lib.mkOption {
      type = lib.types.path;
      description = "path to wallpaper";
    };

    monitor = lib.mkOption {
      type = lib.types.str;
      default = "'*'";
      description = "monitor to display wallpaper";
    };
  };

  config = lib.mkIf config.mpvpaper.enable {
    home.packages = [pkgs.mpvpaper];

    wayland.windowManager.hyprland.settings.exec-once = [
      "${pkgs.mpvpaper}/bin/mpvpaper ${config.mpvpaper.monitor} ${config.mpvpaper.wallpaperPath}"
    ];
  };
}

