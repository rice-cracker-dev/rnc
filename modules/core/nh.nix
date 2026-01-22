{
  inputs',
  config,
  ...
}: let
  inherit (config.core.user) username;
in {
  programs.nh = {
    enable = true;
    package = inputs'.nh.packages.default;
    flake = "/home/${username}/nixos";
    clean.enable = true;
  };
}
