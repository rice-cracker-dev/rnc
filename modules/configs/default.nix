{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) nullOr enum;
in {
  imports = [./mht];

  options.configs = mkOption {
    type = nullOr (enum ["mht"]);
    default = null;
    description = "The name of the configs to use, leave null to use the base config.";
  };
}
