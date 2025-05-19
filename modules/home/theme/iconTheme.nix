{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) package str nullOr submodule;

  cfg = config.home.theme;

  iconThemeType = submodule {
    options = {
      name = mkOption {
        type = str;
        description = "the name of the icon theme";
      };

      package = mkOption {
        type = package;
        description = "the icon theme package";
      };
    };
  };
in {
  options.home.theme.iconTheme = mkOption {
    type = nullOr iconThemeType;
    default = null;
  };

  config.me = mkIf (cfg.enable && cfg.iconTheme != null) {
    rum.misc.gtk = {
      packages = [cfg.iconTheme.package];
      settings.icon-theme-name = cfg.iconTheme.name;
    };
  };
}
