{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./hyprland.nix
    ./lanzaboote.nix
  ];

  desktop.hyprland.enable = true;

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  system.stateVersion = "24.11";
}
