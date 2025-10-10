# setting this up is a headache
# sources:
# https://wiki.nixos.org/wiki/Nvidiagrap
# https://gitlab.com/fazzi/nixohess/-/blob/main/modules/hardware/gpu/nvidia/default.nix
# thanks, fazzi!
{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkMerge;
in {
  services.xserver.videoDrivers = ["modesetting" "nvidia"];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
        vpl-gpu-rt
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [intel-vaapi-driver];
    };

    nvidia = {
      open = true;

      powerManagement = {
        enable = true;
        finegrained = true;
      };

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };

  boot = {
    kernelParams = [
      "nvidia.NVreg_UsePageAttributeTable=1" # why this isn't default is beyond me.
      "nvidia.NVreg_EnableResizableBar=1" # enable reBAR
      "nvidia.NVreg_RegistryDwords=RMIntrLockingMode=1" # enable low-latency mode
      "nvidia_modeset.disable_vrr_memclk_switch=1" # stop really high memclk when vrr is in use.
    ];
  };
}
