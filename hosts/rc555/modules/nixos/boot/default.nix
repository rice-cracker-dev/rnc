{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # enable controller support
  boot.kernelModules = ["hid-playstation" "hid-sony" "usbhid" "joydev"];
}
