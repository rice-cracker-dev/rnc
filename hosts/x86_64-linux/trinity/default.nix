{
  imports = [
    ./hardware-configuration.nix
  ];

  server.enable = true;
  desktop.enable = false;
  system.stateVersion = "25.11";
}
