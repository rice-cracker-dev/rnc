{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [4983];
    checkReversePath = false;
  };
}
