{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.server;
  userCfg = config.core.user;

  keys = import ../../secrets/keys.nix;
in {
  config = mkIf cfg.enable {
    users.users.${userCfg.username}.openssh.authorizedKeys.keys = keys.users;
  };
}
