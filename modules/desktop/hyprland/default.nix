{
  config,
  lib,
  pkgs,
  inputs',
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

      package = inputs'.hyprland.packages.hyprland;
      portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
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
