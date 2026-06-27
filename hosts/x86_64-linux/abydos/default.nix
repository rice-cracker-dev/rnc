{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./lanzaboote.nix
    ./hyprland
  ];

  desktop.hyprland.enable = true;

  system.stateVersion = "24.11";
}
