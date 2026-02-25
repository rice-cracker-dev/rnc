{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (config) desktop;

  cfg = config.desktop.pipewire;
in {
  options.desktop.pipewire = {
    enable = mkEnableOption "pipewire" // {default = desktop.enable;};
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    security.rtkit.enable = true;

    home.packages = with pkgs; [pwvucontrol qpwgraph];
  };
}
