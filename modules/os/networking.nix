{
  networking = {
    enableIPv6 = false;
    networkmanager.enable = true;

    firewall = {
      allowedTCPPorts = [4983];
      checkReversePath = false;
    };
  };
}
