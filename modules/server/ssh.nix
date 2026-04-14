{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.server;
  userCfg = config.core.user;

  keys = ../../secrets/keys.nix;
in {
  config = mkIf cfg.enable {
    users.users.${userCfg.username}.openssh.authorizedKeys.keys = keys.users;
  };
}
