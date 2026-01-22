{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkDefault;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    services.pipewire = {
      enable = mkDefault true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    security.rtkit.enable = mkDefault true;

    home.packages = with pkgs; [pwvucontrol qpwgraph];
  };
}
