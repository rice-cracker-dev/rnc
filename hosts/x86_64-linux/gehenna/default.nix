{
  inputs,
  config,
  ...
}: let
  inherit (config.core.user) username;
in {
  imports = [inputs.nixos-wsl.nixosModules.default];

  desktop.enable = false;
  core.boot.enable = false;
  networking.networkmanager.enable = false;
  nixpkgs.config.cudaSupport = false;

  wsl = {
    enable = true;
    defaultUser = username;
  };

  system.stateVersion = "24.11";
}
