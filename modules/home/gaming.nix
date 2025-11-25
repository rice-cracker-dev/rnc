{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkDefault mkEnableOption;
  inherit (inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}) wine-ge;

  cfg = config.home.gaming;
in {
  options.home.gaming = {
    enable = mkEnableOption "gaming features";
    enableWineGE = mkEnableOption "wine-ge";
  };

  config = {
    home.gaming = {
      enable = mkDefault true;
      enableWineGE = mkDefault true;
    };

    me = mkIf cfg.enable {
      packages = [pkgs.lutris];
      files.".local/share/lutris/runners/wine/wine-ge".source = mkIf cfg.enableWineGE wine-ge;
    };
  };
}
