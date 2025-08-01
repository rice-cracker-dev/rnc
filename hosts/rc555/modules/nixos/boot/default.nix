{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # enable controller support
    kernelModules = [
      "hid-playstation"
      "hid-sony"
      "usbhid"
      "joydev"
    ];

    kernelParams = [
      "intel_iommu=on" # or "amd_iommu=on"
      "iommu=pt"
    ];

    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "i915" # replace or remove with your device's driver as needed
    ];
  };
}
