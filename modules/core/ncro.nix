{
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce mkOverride map;

  cfg = config.services.ncro;
in {
  specialisation.disable-ncro.configuration = {
    services.ncro.enable = mkForce false;

    nix.settings = let
      substituters = mkOverride 10 (map (upstream: upstream.url) config.services.ncro.settings.upstreams);
      publicKeys = mkOverride 10 (map (upstream: upstream.public_key) config.services.ncro.settings.upstreams);
    in {
      inherit substituters;
      trusted-public-keys = publicKeys;
    };
  };

  services.ncro = {
    enable = true;

    settings = {
      server.listen = ":4080";

      upstreams = [
        {
          url = "https://cache.nixos.org";
          public_key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
          priority = 10;
        }
        {
          url = "https://nix-community.cachix.org";
          public_key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
          priority = 20;
        }
        {
          url = "https://cache.nixos-cuda.org";
          public_key = "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=";
          priority = 30;
        }
        {
          url = "https://nix-gaming.cachix.org";
          public_key = "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=";
          priority = 30;
        }
        {
          url = "https://hyprland.cachix.org";
          public_key = "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
          priority = 30;
        }
        {
          url = "https://niri.cachix.org";
          public_key = "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=";
          priority = 30;
        }
      ];
    };
  };

  nix.settings.substituters = mkForce ["http://localhost${cfg.settings.server.listen}"];
}
