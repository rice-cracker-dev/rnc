{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    home.rum.programs.obs-studio = {
      enable = true;

      package =
        pkgs.wrapOBS.override {
          obs-studio = pkgs.obs-studio.override {
            cudaSupport = true;
          };
        } {
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-backgroundremoval
            obs-pipewire-audio-capture
            obs-vkcapture
            obs-multi-rtmp
            droidcam-obs
          ];
        };
    };

    boot = {
      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
      kernelModules = ["v4l2loopback"];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
    };
  };
}
