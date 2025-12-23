{
  inputs,
  username,
  ...
}: {
  imports = [
    "${inputs.self}/modules"
    ./modules/nixos
    inputs.nixos-wsl.nixosModules.default
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "storage"
      "networkmanager"
      "docker"
      "adbusers"
    ];
  };

  wsl = {
    enable = true;
    defaultUser = username;
  };

  system.stateVersion = "24.11";
}
