{
  pkgs,
  config,
  riceLib,
  lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) attrsOf;
  inherit (riceLib.types) tomlType;
  inherit (pkgs.writers) writeTOML;

  cfg = config.home.yazi;

  baseSettings = {
    opener = {
      play = [
        {
          run = "mpv \"$@\"";
          orphan = true;
          for = "unix";
        }
      ];

      edit = [
        {
          run = "$EDITOR \"$@\"";
          block = true;
          for = "unix";
        }
      ];

      open = [
        {run = "xdg-open \"$@\"";}
      ];
    };

    open.rules = [
      {
        mime = "text/*";
        use = "edit";
      }
      {
        mine = "video/*";
        use = "play";
      }
    ];
  };
in {
  options.home.yazi = {
    enable = mkEnableOption "yazi";

    settings = mkOption {
      type = attrsOf tomlType;
      default = {};
      description = "yazi config";
    };
  };

  config.me = mkIf cfg.enable {
    packages = [pkgs.yazi];
    files.".config/yazi/yazi.toml".source = writeTOML "yazi-config" (baseSettings // cfg.settings);
  };
}
