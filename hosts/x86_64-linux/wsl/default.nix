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

  wsl = {
    enable = true;
    defaultUser = username;
    interop.includePath = false;
  };

  system.stateVersion = "24.11";
}
