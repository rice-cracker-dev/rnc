{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.core.hardware.intel;
  graphicsCfg = config.core.hardware.graphics;

  videoAccelerationEnabled = graphicsCfg.videoAcceleration == "intel";
in {
  options.core.hardware.intel = {
    enable = mkEnableOption "intel";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = mkIf videoAccelerationEnabled {
      LIBVA_DRIVER_NAME = "iHD";
    };

    hardware.graphics = {
      extraPackages = mkIf videoAccelerationEnabled [pkgs.intel-media-driver];
      extraPackages32 = mkIf videoAccelerationEnabled [pkgs.pkgsi686Linux.intel-media-driver];
    };
  };
}
