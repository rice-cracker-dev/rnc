{
  inputs,
  username,
  ...
}: {
  imports = [
    "${inputs.self}/modules/nixos"
    "${inputs.self}/modules/themes/mht/nixos"
    ./modules/nixos
    ./hardware-configuration.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "storage"
      "power"
      "networkmanager"
      "docker"
      "libvirtd"
      "adbusers"
    ];
  };

  system.stateVersion = "24.11";
}
