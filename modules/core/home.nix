{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkAliasOptionModule;
  inherit (config.core.user) username;
in {
  imports = [
    inputs.hjem.nixosModules.default
    (mkAliasOptionModule ["home"] ["hjem" "users" username])
  ];

  config.hjem = {
    extraModules = [
      inputs.hjem-rum.hjemModules.default
    ];

    clobberByDefault = true;

    users.${username} = {
      directory = "/home/${username}";
      packages = with pkgs; [
        parted
        fd
        ripgrep
        diskus
        libqalculate
        btdu
        android-tools
        wget
      ];
    };
  };
}
