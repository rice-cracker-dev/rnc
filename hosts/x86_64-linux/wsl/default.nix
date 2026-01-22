{
  inputs,
  config,
  ...
}: let
  inherit (config.core.user) username;
in {
  imports = [inputs.nixos-wsl.nixosModules.default];

  core.desktop.enable = false;

  wsl = {
    enable = true;
    defaultUser = username;
    wsl.interop.includePath = false;
  };

  system.stateVersion = "24.11";
}
