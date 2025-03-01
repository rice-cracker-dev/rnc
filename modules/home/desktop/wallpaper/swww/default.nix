{pkgs, config, lib, ...}: {
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

    systemd.user.services.swww = {
      # shamelessly taken from https://github.com/nix-community/home-manager/blob/release-24.05/modules/services/hyprpaper.nix
      Install = { WantedBy = [ "graphical-session.target" ]; };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "swww";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${swwwPkg}/bin/swww-daemon --no-cache";
        ExecStartPost = "${swwwPkg}/bin/swww img ${config.swww.wallpaperPath}";
      };
    };
  };
}

