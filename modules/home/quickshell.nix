{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) path;

  quickshellPkg = inputs.quickshell.packages.${pkgs.system}.default;
  cfg = config.home.quickshell;
in {
  options.home.quickshell = {
    enable = mkEnableOption "quickshell";

    configDir = mkOption {
      type = path;
      description = "config directory for quickshell";
    };
  };

  config.me = mkIf cfg.enable {
    packages = [quickshellPkg];

    files.".config/quickshell".source = cfg.configDir;

    rum.programs.hyprland.settings.exec-once = [
      "${quickshellPkg}/bin/quickshell"
    ];
  };
}
