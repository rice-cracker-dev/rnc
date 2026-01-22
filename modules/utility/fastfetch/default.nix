{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption mkEnableOption;
  inherit (lib.types) attrsOf anything;
  inherit (lib.generators) toJSON;

  cfg = config.utility.fastfetch;
in {
  options.utility.fastfetch = {
    enable = mkEnableOption "fastfetch" // {default = true;};

    settings = mkOption {
      type = attrsOf anything;
      default = {
        display = {
          color = {keys = "magenta";};
          key = {width = 10;};
          separator = "";
        };
        logo = {
          padding = {
            right = 4;
            top = 1;
          };
          source = ./hopeshino.png;
          type = "auto";
        };
        modules = [
          {type = "break";}
          {
            key = "system";
            type = "os";
          }
          {
            key = "kernel";
            type = "kernel";
          }
          {
            key = "shell";
            type = "shell";
          }
          {
            key = "uptime";
            type = "uptime";
          }
          {
            key = "utility";
            type = "wm";
          }
          {
            key = "cpu";
            type = "cpu";
          }
          {
            key = "gpu";
            type = "gpu";
          }
          {
            key = "memory";
            type = "memory";
          }
          {
            key = "storage";
            type = "disk";
          }
          {
            key = "colors";
            symbol = "circle";
            type = "colors";
          }
          {type = "break";}
          {
            key = "uheeeeeeeee~";
            type = "custom";
          }
        ];
      };
    };
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [fastfetch];

    xdg.config.files."fastfetch/config.jsonc" = {
      enable = cfg.settings != {};
      generator = toJSON {};
      value = cfg.settings;
    };
  };
}
