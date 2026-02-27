{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption mkEnableOption;
  inherit (lib.types) int;

  cfg = config.desktop.pipewire.low-latency;
  pulseValue = "${toString cfg.quantum}/${toString cfg.rate}";
in {
  options.desktop.pipewire.low-latency = {
    enable = mkEnableOption "pipewire low latency configurations";

    rate = mkOption {
      type = int;
      default = 48000;
    };

    quantum = mkOption {
      type = int;
      default = 64;
    };
  };

  config.services.pipewire.extraConfig = mkIf cfg.enable {
    pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = cfg.rate;
        "default.clock.quantum" = cfg.quantum;
        "default.clock.min-quantum" = cfg.quantum;
        "default.clock.max-quantum" = cfg.quantum;
      };
    };

    pipewire-pulse."92-low-latency" = {
      "context.properties" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {};
        }
      ];
      "pulse.properties" = {
        "pulse.min.req" = pulseValue;
        "pulse.default.req" = pulseValue;
        "pulse.max.req" = pulseValue;
        "pulse.min.quantum" = pulseValue;
        "pulse.max.quantum" = pulseValue;
      };
      "stream.properties" = {
        "node.latency" = pulseValue;
        "resample.quality" = 1;
      };
    };
  };
}
