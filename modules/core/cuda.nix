{lib, ...}: let
  inherit (lib) mkDefault;
in {
  nixpkgs.config.cudaSupport = mkDefault true;
}
