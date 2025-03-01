{
  inputs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/nixos
    "${inputs.self}/modules/nix"
    "${inputs.self}/modules/nixos"
    "${inputs.self}/modules/themes/mht/nixos"
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

  home-manager.users.${username} = import ./home.nix;

  system.stateVersion = "24.11";
}
