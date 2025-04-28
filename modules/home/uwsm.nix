{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption concatStringSep;
  inherit (lib.types) str attrsOf;
  inherit (lib.attrsets) mapAttrs;

  cfg = config.home.uwsm;
in {
  options.home.uwsm.env = mkOption {
    type = attrsOf str;
    description = "environment variables for uwsm";
    default = [];
  };

  config.home.files.".config/uwsm/env".text = concatStringSep "\n" (
    mapAttrs (name: value: "export ${name}=${value}") cfg.env
  );
}
