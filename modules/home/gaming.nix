{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkDefault mkEnableOption;
  inherit (inputs.nix-gaming.packages.${pkgs.system}) wine-ge;

  cfg = config.home.gaming;
in {
  options.home.gaming.enable = mkEnableOption "enable gaming features";

  config = {
    home.gaming.enable = mkDefault true;

    me = {
      packages = [pkgs.lutris];
      files.".local/share/lutris/runners/wine/wine-ge".source = mkIf cfg.enable wine-ge;
    };
  };
}
