# isetting this up is a headache
# sources:
# https://wiki.nixos.org/wiki/Nvidiagrap
# https://gitlab.com/fazzi/nixohess/-/blob/main/modules/hardware/gpu/nvidia/default.nix
# thanks, fazzi!
{
  config,
  pkgs,
  ...
}: let
  package = config.boot.kernelPackages.nvidiaPackages.stable;
in {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };

    nvidia = {
      package = pkgs.nvidia-patch.patch-nvenc (pkgs.nvidia-patch.patch-fbc package);
      open = true;
      powerManagement.enable = true;

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        sync = {
          enable = true;
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

  home.uwsm.env = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
  };
}
