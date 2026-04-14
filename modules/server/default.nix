{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.server = {
    enable = mkEnableOption "server";
  };
}
