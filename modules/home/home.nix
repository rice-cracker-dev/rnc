{
  inputs,
  lib,
  username,
  pkgs,
  ...
}: let
  inherit (lib) mkAliasOptionModule;
in {
  imports = [
    inputs.hjem.nixosModules.default
    (mkAliasOptionModule ["me"] ["hjem" "users" username])
  ];

  config.hjem = {
    extraModules = [inputs.hjem-rum.hjemModules.default];
    linker = inputs.smfh.packages.${pkgs.system}.default;
    clobberByDefault = true;

    users.${username} = {
      enable = true;
      directory = "/home/${username}";
      user = username;
    };
  };
}
