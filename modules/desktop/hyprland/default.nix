{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    home = {
      packages = with pkgs; [hyprpicker];

      xdg.config.files = {
        "hypr/config".source = ./config;

        "hypr/hyprland.lua".text = ''
          require("config")
        '';
      };
    };
  };
}
