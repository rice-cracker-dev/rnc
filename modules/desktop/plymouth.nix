{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.boot = mkIf desktop.enable {
    plymouth = {
      enable = true;
      theme = "catppuccin-macchiato";
      themePackages = [(pkgs.catppuccin-plymouth.override {variant = "macchiato";})];
    };

    kernelParams = ["quiet" "splash"];
  };
}
