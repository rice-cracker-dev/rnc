{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./lanzaboote.nix
    ./hyprland.nix
  ];

  desktop.hyprland.enable = true;

  system.stateVersion = "24.11";
}
