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
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # kernelPackages = pkgs.linuxPackages_6_18;
    };
  };
}
