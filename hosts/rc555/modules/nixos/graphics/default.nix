# setting this up is a headache
# sources:
# https://wiki.nixos.org/wiki/Nvidiagrap
# https://gitlab.com/fazzi/nixohess/-/blob/main/modules/hardware/gpu/nvidia/default.nix
# thanks, fazzi!
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkMerge;
in {
  services.xserver.videoDrivers = ["modesetting" "nvidia"];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
        vpl-gpu-rt
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [intel-vaapi-driver];
    };

    nvidia = {
      open = true;

      nvidiaSettings = false;
      nvidiaPersistenced = false;
      videoAcceleration = true;

      gsp.enable = true;
      powerManagement.enable = true;

      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "575.64.05";
        sha256_64bit = "sha256-hfK1D5EiYcGRegss9+H5dDr/0Aj9wPIJ9NVWP3dNUC0=";
        openSha256 = "sha256-mcbMVEyRxNyRrohgwWNylu45vIqF+flKHnmt47R//KU=";
        usePersistenced = false;
        useSettings = false;
      };
    };
  };

  boot = {
    kernelParams = mkMerge [
      [
        "nvidia.NVreg_UsePageAttributeTable=1" # why this isn't default is beyond me.
        "nvidia.NVreg_EnableResizableBar=1" # enable reBAR
        "nvidia.NVreg_RegistryDwords=RMIntrLockingMode=1" # enable low-latency mode
        "nvidia_modeset.disable_vrr_memclk_switch=1" # stop really high memclk when vrr is in use.
      ]
      (mkIf config.hardware.nvidia.powerManagement.enable [
        "nvidia.NVreg_TemporaryFilePath=/var/tmp" # store on disk, not /tmp which is on RAM
      ])
    ];
  };
}
