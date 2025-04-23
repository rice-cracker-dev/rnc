{inputs, pkgs, config, lib, ...}: let
  uwsm = import "${inputs.self}/lib/uwsm.nix";
in {
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
      (uwsm.useUWSM "mpvpaper ${config.mpvpaper.monitor} ${config.mpvpaper.wallpaperPath}")
    ];
  };
}

