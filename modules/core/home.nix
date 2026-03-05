{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkAliasOptionModule;
  inherit (config.core.user) username packages;
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
      inherit packages;
      directory = "/home/${username}";
    };
  };
}
