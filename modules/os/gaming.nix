{inputs, ...}: let
  inherit (inputs.nix-gaming.nixosModules) pipewireLowLatency platformOptimizations;
in {
  imports = [pipewireLowLatency platformOptimizations];

  services.pipewire.lowLatency = {
    enable = true;
    quantum = 64;
    rate = 48000;
  };

  programs.steam.platformOptimizations.enable = true;
}
