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
    files.".config/yazi/yazi.toml".source = writeTOML "yazi-config" cfg.settings;
  };
}
