{
  inputs,
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkAliasOptionModule;
in {
  imports = [
    inputs.hjem.nixosModules.default
    (mkAliasOptionModule ["home"] ["hjem" "users" username])
  ];

  config.hjem = {
    extraModules = [inputs.hjem-rum.hjemModules.default];

    users.${username} = {
      enable = true;
      directory = "/home/${username}";
      user = username;
    };

    clobberByDefault = true;
  };
}
