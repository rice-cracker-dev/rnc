{
  inputs,
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) listOf package;
in {
  imports = [inputs.hjem.nixosModules.default];

  options.home = {
    enable = mkEnableOption "enable home configurations";

    packages = mkOption {
      type = listOf package;
      default = [];
      description = "list of packages for user ${username}";
    };
  };

  config.hjem = {
    extraModules = [inputs.hjem-rum.hjemModules.default];

    users.${username} = {
      inherit (config.home) enable packages;
      directory = "/home/${username}";
      user = username;
    };

    clobberByDefault = true;
  };
}
