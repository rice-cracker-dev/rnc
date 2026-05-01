{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.server.tailscale;
in {
  options.server.tailscale = {
    enable = mkEnableOption "tailscale" // {default = true;};

    # only used on servers, for desktops we can just do `tailscale login` to avoid decrypting tailscale-key.age
    enableAuthKey = mkEnableOption "tailscale auth key for authentication";
  };
  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      authKeyFile = mkIf cfg.enableAuthKey config.age.secrets.tailscale-key.path;
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

    age.secrets.tailscale-key = mkIf cfg.enableAuthKey {
      file = ../../secrets/tailscale-key.age;
    };
  };
}
