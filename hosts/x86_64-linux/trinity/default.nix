{
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
    ./disko-configuration.nix
    ./hardware-configuration.nix
    ./tailscale.nix
  ];

  server.enable = true;
  desktop.enable = false;
  system.stateVersion = "25.11";
}
