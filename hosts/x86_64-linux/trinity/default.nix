{
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
    ./disko-config.nix
    ./hardware-configuration.nix
  ];

  server.enable = true;
  system.stateVersion = "25.11";
}
