{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.core.boot;
in {
  options.core.boot = {
    enable = mkEnableOption "system bootloader" // {default = true;};
  };

  config = {
    boot = {
      loader = mkIf cfg.enable {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };

      kernel.sysctl = {
        "fs.inotify.max_user_watches" = 1048576;
        "fs.inotify.max_user_instances" = 2048;
        "fs.inotify.max_queued_events" = 65536;
      };
    };
  };
}
