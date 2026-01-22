# took some configs from
# https://gitlab.com/fazzi/nixohess/-/blob/main/modules/hardware/nvidia.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkOption optionals;
  inherit (lib.types) submodule str nullOr;
  inherit (pkgs.nvidia-patch) patch-nvenc patch-fbc;

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

  # nvidia package to patch
  package = config.boot.kernelPackages.nvidiaPackages.stable;
  patchedPackage = patch-nvenc (patch-fbc package);
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

    hardware.nvidia = {
      package = patchedPackage;

      open = true;
      powerManagement.enable = true;
      videoAcceleration = true;
      modesetting.enable = cfg.offload != null;

      prime = mkIf (cfg.offload != null) {
        inherit (cfg.offload) intelBusId nvidiaBusId amdgpuBusId;

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };

    environment = {
      sessionVariables = {
        # disable vsync
        __GL_SYNC_TO_VBLANK = "0";
        # enable gsync / vrr support
        __GL_VRR_ALLOWED = "1";
        # lowest frame buffering -> lower latency
        __GL_MaxFramesAllowed = "1";
        # no idea what this does but apparently useful
        # __GL_YIELD = "usleep";
        # fix hw acceleration and native wayland on losslesscut
        __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
        # fix hw acceleration in bwrap (osu!lazer, wrapped appimages)
        __EGL_EXTERNAL_PLATFORM_CONFIG_DIRS = "/run/opengl-driver/share/egl/egl_external_platform.d";
        CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
        # stop forcing high GPU clocks when CUDA is in use
        CUDA_DISABLE_PERF_BOOST = 1;
      };

      # fix high vram usage on discord and hyprland. match with the wrapper procnames
      etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool.json".text = builtins.toJSON {
        rules =
          map (proc: {
            pattern = {
              feature = "procname";
              matches = proc;
            };
            profile = "No VidMem Reuse";
          }) [
            ".Hyprland-wrapped"
            "Discord"
            ".Discord-wrapped"
            "electron"
            ".electron-wrapped"
            "librewolf"
            ".librewolf-wrapped"
            "losslesscut"
            ".losslesscut-wrapped"
            "hyprpaper"
          ];
      };
    };

    boot = {
      blacklistedKernelModules = ["nouveau"];

      kernelParams =
        [
          "nvidia.NVreg_UsePageAttributeTable=1" # why this isn't default is beyond me.
          "nvidia.NVreg_EnableResizableBar=1" # enable reBAR
          "nvidia.NVreg_RegistryDwords=RmEnableAggressiveVblank=1" # low-latency stuff
          "nvidia-modeset.disable_vrr_memclk_switch=1"
        ]
        ++ optionals config.hardware.nvidia.powerManagement.enable [
          "nvidia.NVreg_TemporaryFilePath=/var/tmp" # store on disk, not /tmp which is on RAM
          "nvidia.NVreg_EnableS0ixPowerManagement=0"
        ];
    };
  };
}
