{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) int;

  cfg = config.desktop.pipewire;
  pulseValue = "${toString cfg.low-latency.quantum}/${toString cfg.low-latency.rate}";
in {
  options.desktop.pipewire.low-latency = {
    rate = mkOption {
      type = int;
      default = 48000;
    };

    quantum = mkOption {
      type = int;
      default = 64;
    };
  };

  config.services.pipewire.extraConfig = {
    pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = cfg.low-latency.rate;
        "default.clock.quantum" = cfg.low-latency.quantum;
        "default.clock.min-quantum" = cfg.low-latency.quantum;
        "default.clock.max-quantum" = cfg.low-latency.quantum;
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
