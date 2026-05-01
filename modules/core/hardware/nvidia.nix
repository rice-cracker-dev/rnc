# took some configs from
# https://gitlab.com/fazzi/nixohess/-/blob/main/modules/hardware/nvidia.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkOption;
  inherit (lib.types) submodule str nullOr;

  offloadOptions = submodule {
    options = {
      intelBusId = mkOption {
        type = str;
        default = "";
      };
      nvidiaBusId = mkOption {
        type = str;
        default = "";
      };
      amdgpuBusId = mkOption {
        type = str;
        default = "";
      };
    };
  };

  cfg = config.core.hardware.nvidia;
  graphicsCfg = config.core.hardware.graphics;

  videoAccelerationEnabled = graphicsCfg.videoAcceleration == "nvidia";
in {
  options.core.hardware.nvidia = {
    enable = mkEnableOption "novideo";

    offload = mkOption {
      type = nullOr offloadOptions;
      default = null;
    };
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = mkIf videoAccelerationEnabled "nvidia";
      NVD_BACKEND = mkIf videoAccelerationEnabled "direct";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    hardware = {
      nvidia = {
        open = false;
        videoAcceleration = videoAccelerationEnabled;
        nvidiaSettings = false;
        powerManagement.enable = true;
        modesetting.enable = cfg.offload != null;

        prime = mkIf (cfg.offload != null) {
          inherit (cfg.offload) intelBusId nvidiaBusId amdgpuBusId;

          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };

    environment.systemPackages = [pkgs.nvtopPackages.nvidia];
  };
}
