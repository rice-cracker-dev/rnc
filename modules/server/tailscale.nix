{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.server;
in {
  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tailscale-key.path;
    };

    networking.firewall = {
      allowedUDPPorts = [config.services.tailscale.port];
      trustedInterfaces = ["tailscale0"];
    };

    systemd.services.tailscaled.serviceConfig.Environment = mkIf config.networking.nftables.enable [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];

    systemd.network.wait-online.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;

    age.secrets.tailscale-key.file = ../../secrets/tailscale-key.age;
  };
}
