{
  lib,
  config,
  ...
}: let
  inherit (lib) mkForce mkIf;

  nvidiaCfg = config.core.hardware.nvidia;
in {
  config = {
    core.hardware = {
      graphics = {
        enable = true;
        videoAcceleration = "intel";
      };

      intel = {
        enable = true;
      };

      nvidia = {
        enable = true;

        offload = {
          nvidiaBusId = "PCI:1@0:0:0";
          intelBusId = "PCI:0@0:2:0";
        };
      };
    };

    desktop.uwsm.desktopEnv.hyprland.AQ_DRM_DEVICES = mkIf nvidiaCfg.enable "/dev/dri/card1:/dev/dri/card2";

    specialisation.disable-nvidia.configuration = {
      core.hardware.nvidia.enable = mkForce false;
    };
  };
}
