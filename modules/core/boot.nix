{
  config,
  lib,
  pkgs,
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

      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    };
  };
}
