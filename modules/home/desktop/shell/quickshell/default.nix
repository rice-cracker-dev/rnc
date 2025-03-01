{inputs, pkgs, config, lib, ...}: {
  options.quickshell = {
    enable = lib.mkEnableOption "enable quickshell";

    configDir = lib.mkOption {
      type = lib.types.path;
      description = "path to quickshell config";
    };
  };

  config = let 
    quickshellPkg = inputs.quickshell.packages.${pkgs.system}.default;
  in lib.mkIf config.quickshell.enable {
    home.packages = [quickshellPkg];

    xdg.configFile.quickshell = {
      source = config.quickshell.configDir;
      recursive = true;
    };

    systemd.user.services.quickshell = {
      # shamelessly taken from https://github.com/nix-community/home-manager/blob/release-24.05/modules/services/hyprpaper.nix
      Install = { WantedBy = [ "graphical-session.target" ]; };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "quickshell";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${quickshellPkg}/bin/quickshell";
      };
    };
  };
}
