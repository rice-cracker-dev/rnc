{
  inputs,
  username,
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) attrsOf anything;
in {
  imports = [
    inputs.hjem.nixosModules.default
  ];

  options.rum = mkOption {
    type = attrsOf anything;
    default = {};
    description = "shorthand for hjem.users.${username}.rum";
  };

  config.hjem = {
    extraModules = [inputs.hjem-rum.hjemModules.default];

    users.${username} = {
      enable = true;
      directory = "/home/${username}";
      user = username;

      inherit (config) rum;
    };

    clobberByDefault = true;
  };
}
