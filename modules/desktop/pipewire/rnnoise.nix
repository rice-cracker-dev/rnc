# taken from
# https://gitlab.com/fazzi/nixohess/-/blob/main/modules/services/pipewire/rnnoise.nix
{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) int;

  cfg = config.desktop.pipewire;

  pw_rnnoise_config = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Cancelling source";
          "media.name" = "Noise Cancelling source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_mono";
                "control" = {
                  "VAD Threshold (%)" = cfg.rnnoise.vadThreshold;
                  "VAD Grace Period (ms)" = cfg.rnnoise.vadGracePeriod;
                  "Retroactive VAD Grace (ms)" = cfg.rnnoise.retroactiveVadGrace;
                };
              }
            ];
          };
          "audio.rate" = 48000;
          "audio.position" = ["MONO"];
          "capture.props" = {
            "node.name" = "capture.rnnoise_source";
            "node.passive" = true;
            "audio.rate" = 48000;
            "audio.channels" = 1;
          };
          "playback.props" = {
            "node.name" = "rnnoise_source";
            "media.class" = "Audio/Source";
            "audio.channels" = 1;
          };
        };
      }
    ];
  };
in {
  options.desktop.pipewire.rnnoise = {
    vadThreshold = mkOption {
      type = int;
      default = 50;
      description = "Set the rnnoise VAD threshold (%)";
    };

    vadGracePeriod = mkOption {
      type = int;
      default = 200;
      description = "Set the rnnoise VAD grace period in milliseconds.";
    };

    retroactiveVadGrace = mkOption {
      type = int;
      default = 0;
      description = "Set the rnnoise retroactive VAD grace period in milliseconds.";
    };
  };

  config.services.pipewire = mkIf cfg.enable {
    extraConfig.pipewire."99-input-denoising" = pw_rnnoise_config; # Add rnnoise-plugin filters
  };
}
