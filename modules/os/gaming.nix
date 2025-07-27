{inputs, ...}: let
  inherit (inputs.nix-gaming.nixosModules) pipewireLowLatency platformOptimizations;
in {
  imports = [pipewireLowLatency platformOptimizations];

  nix.settings = {
    extra-substituters = ["https://nix-gaming.cachix.org"];
    extra-trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  services.pipewire.lowLatency = {
    enable = true;
    quantum = 64;
    rate = 48000;
  };

  programs.steam.platformOptimizations.enable = true;
}
