{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (config) desktop;

  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    enable = mkEnableOption "hyprland" // {default = desktop.enable;};
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    home = {
      packages = with pkgs; [hyprpicker];

      rum.desktops.hyprland = {
        enable = true;

        settings = {
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };

          input = {
            accel_profile = "flat";
          };

          general = {
            gaps_in = 4;
            gaps_out = 4;
            resize_on_border = true;

            "col.inactive_border" = "0xff363a4f";
            "col.active_border" = "0xffc6a0f6";
          };

          decoration = {
            rounding = 4;

            blur = {
              passes = 3;
              size = 8;
            };
          };

          layerrule = [
            "blur on, match:namespace quickshell"
            "blur_popups on, match:namespace quickshell"
            "ignore_alpha 0.5, match:namespace quickshell"
            "blur on, match:namespace launcher"
          ];

          windowrule = [
            "no_anim on, match:title flameshot"
            "move 0 0, match:title flameshot"
            "pin on, match:title flameshot"
            "fullscreen_state 2, match:title flameshot"
            "float on, match:title flameshot"
          ];

          bezier = ["easeOutQuint, 0.22, 1, 0.36, 1"];
          animation = ["global, 1, 3, easeOutQuint"];
        };
      };
    };
  };
}
