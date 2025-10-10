{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = {
    me.rum.programs.ghostty = {
      enable = true;
      settings = {
        theme = "Catppuccin Macchiato";
        font-family = "JetBrainsMono Nerd Font";
        background = "#000000";
        background-opacity = 0.8;
        shell-integration-features = true;
      };
    };

    home.hyprland.binds.programs.terminal.exec = mkIf config.me.rum.programs.ghostty.enable "ghostty";
  };
}
