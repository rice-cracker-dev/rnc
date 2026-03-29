{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.core.hardware.intel;

  videoAccelerationPackage = mkIf cfg.videoAcceleration.enable [pkgs.intel-media-driver];
in {
  options.core.hardware.intel = {
    enable = mkEnableOption "intel";
    videoAcceleration.enable = mkEnableOption "video acceleration";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = mkIf cfg.videoAcceleration.enable {
      LIBVA_DRIVER_NAME = "iHD";
    };

    hardware.graphics = {
      extraPackages = videoAccelerationPackage;
      extraPackages32 = videoAccelerationPackage;
    };
  };
}
