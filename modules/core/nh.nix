{
  inputs',
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.core.user) username;

  serverCfg = config.server;
in {
  programs.nh = mkIf (!serverCfg.enable) {
    enable = true;
    package = inputs'.nh.packages.default;
    flake = "/home/${username}/nixos";
    clean.enable = true;
  };
}
