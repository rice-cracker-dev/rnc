{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.core.hardware.intel;
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
      extraPackages = mkIf cfg.videoAcceleration.enable [pkgs.intel-media-driver];
      extraPackages32 = mkIf cfg.videoAcceleration.enable [pkgs.pkgsi686Linux.intel-media-driver];
    };
  };
}
