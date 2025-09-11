{
  lib,
  config,
  ...
}: {
  options = {
    custom-module.enable = lib.mkEnableOption "custom module";
  };

  config =
    lib.mkIf config.custom-module.enable {
    };
}
