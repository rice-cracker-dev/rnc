{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = {
    me.rum.programs.ghostty = {
      enable = false;
      settings = {
        theme = "Rose Pine";
        font-family = "JetBrainsMono Nerd Font";
        shell-integration-features = true;
        working-directory = "home";
        window-inherit-working-directory = false;
      };
    };

    home.hyprland.binds.programs.terminal.exec = mkIf config.me.rum.programs.ghostty.enable "ghostty";
  };
}
