{
  lib,
  config,
  ...
}: {
  config.home.yazi = lib.mkIf (config.configs == "mht") {
    enable = true;
  };
}
