{pkgs, config, lib, inputs, ...}: let
  uwsm = import "${inputs.self}/lib/uwsm.nix";
in {
  options.swww = {
    enable = lib.mkEnableOption "enable swww";
    
    wallpaperPath = lib.mkOption {
      type = lib.types.path;
      description = "path to wallpaper";
    };
  };

  config = let
    swwwPkg = pkgs.swww;
  in lib.mkIf config.swww.enable {
    home.packages = [swwwPkg];

    wayland.windowManager.hyprland.settings.exec-once = [
      (uwsm.useUWSM "swww-daemon --no-cache & sleep 1 && swww img ${config.swww.wallpaperPath}")
    ];
  };
}

