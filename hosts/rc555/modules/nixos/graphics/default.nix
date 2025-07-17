{
  services.xserver.videoDrivers = ["modesetting" "nvidia"];

  hardware = {
    graphics.enable = true;
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
