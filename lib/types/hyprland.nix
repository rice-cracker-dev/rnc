{lib}: let
  inherit (lib) mkOption;
  inherit (lib.types) submodule str attrsOf anything;
in {
  hyprlandBind = submodule {
    options = {
      key = mkOption {type = str;};
      action = mkOption {type = str;};

      flag = mkOption {
        type = attrsOf anything;
        default = {};
      };
    };
  };
}
