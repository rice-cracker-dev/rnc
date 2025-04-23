{
  inputs,
  username,
  ...
}: {
  imports = [
    "${inputs.self}/modules/nix"
    "${inputs.self}/modules"
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

  home-manager.users.${username} = import ./home.nix;

  system.stateVersion = "24.11";
}
