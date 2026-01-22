{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str listOf;

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
        "input"
        "storage"
        "power"
        "docker"
        "adbusers"
      ];
    };

    extraGroups = mkOption {
      type = listOf str;
      default = [];
    };
  };

  config.users.users.${cfg.username} = {
    isNormalUser = true;
    extraGroups = cfg.groups ++ cfg.extraGroups;
  };
}
