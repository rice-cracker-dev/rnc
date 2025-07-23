{pkgs, ...}: {
  services.xserver.videoDrivers = ["modesetting" "nvidia"];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
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
      prime = {
        intelBusId = "PCI:0:2:0"; # 00:02.0
        nvidiaBusId = "PCI:1:0:0"; # 01:00.0

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
}
