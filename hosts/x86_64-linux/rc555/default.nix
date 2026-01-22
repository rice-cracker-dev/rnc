{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./hyprland.nix
  ];

  system.stateVersion = "24.11";
}
