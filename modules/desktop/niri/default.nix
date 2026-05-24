{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.desktop.niri;
in {
  options.desktop.niri = {
    enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };

      uwsm.waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };
    };

    niri-flake.cache.enable = false;

    home.rum.desktops.niri = {
      enable = true;
      config = builtins.readFile ./config.kdl;
    };
  };
}
