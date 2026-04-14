{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str package listOf;

  cfg = config.core.user;
in {
  options.core.user = {
    username = mkOption {
      type = str;
      default = "khoa";
    };

    groups = mkOption {
      type = listOf str;
      default = [
        "wheel"
      ];
    };

    extraGroups = mkOption {
      type = listOf str;
      default = [];
    };

    packages = mkOption {
      type = listOf package;
      default = with pkgs; [
        parted
        fd
        ripgrep
        diskus
        btdu
        wget
      ];
    };
  };

  config.users.users.${cfg.username} = {
    isNormalUser = true;
    extraGroups = cfg.groups ++ cfg.extraGroups;
  };
}
