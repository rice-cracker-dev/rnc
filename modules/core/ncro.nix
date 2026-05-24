{
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce;

  cfg = config.services.ncro;
in {
  services.ncro = {
    enable = true;

    settings = {
      server.listen = ":4080";

      upstreams = [
        {
          url = "https://cache.nixos.org";
          priority = 10;
        }
        {
          url = "https://nix-community.cachix.org";
          priority = 20;
        }
        {
          url = "https://cache.nixos-cuda.org";
          priority = 30;
        }
        {
          url = "https://nix-gaming.cachix.org";
          priority = 30;
        }
        {
          url = "https://hyprland.cachix.org";
          priority = 30;
        }
        {
          url = "https://niri.cachix.org";
          priority = 30;
        }
      ];
    };
  };

  nix.settings.substituters = mkForce ["http://localhost${cfg.settings.server.listen}"];
}
