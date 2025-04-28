{
  config,
  lib,
  ...
}:
lib.mkIf (config.configs == "mht") {
  imports = [./home];
}
