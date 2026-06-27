{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) anything attrsOf;

  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland.config = mkOption {
    type = attrsOf anything;
    description = "Hyprland variables, converted to lua object and passed into hl.config({...})";
    default = {
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
      input = {accel_profile = "flat";};

      general = {
        layout = "scrolling";

        gaps_in = 4;
        gaps_out = 4;

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
    };
  };

  config = {
    desktop.hyprland.luaConfig.config = ''
      hl.config(${cfg.generator cfg.config})
    '';
  };
}
