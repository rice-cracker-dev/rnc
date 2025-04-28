{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.type) package str nullOr submodule;

  cfg = config.home.theme;

  iconThemeType = submodule {
    name = mkOption {
      type = str;
      description = "the name of the icon theme";
    };

    package = mkOption {
      type = package;
      description = "the icon theme package";
    };
  };
in {
  options.home.theme.iconTheme = mkOption {
    type = nullOr iconThemeType;
    default = null;
  };

  config.home =
    mkIf cfg.enable
    && cfg.iconTheme
    != null {
      rum.gtk = {
        package = [cfg.iconTheme.package];
        settings.icon-theme-name = cfg.iconTheme.name;
      };
    };
}
