{
  lib,
  hostName,
  ...
}: let
  inherit (lib) mkDefault;
in {
  networking = {
    inherit hostName;

    networkmanager = {
      enable = mkDefault true;
    };

    firewall = {
      allowedTCPPorts = [
        4983 # drizzle studio
      ];
    };
  };
}
