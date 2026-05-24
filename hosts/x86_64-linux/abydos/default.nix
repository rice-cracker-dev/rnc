{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./lanzaboote.nix
  ];

  desktop.hyprland.enable = true;

  system.stateVersion = "24.11";
}
