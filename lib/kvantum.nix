lib: let
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.strings) concatStringsSep;

  toConfProperty = properties:
    concatStringsSep "\n" (mapAttrsToList (property: value: "${property}=${value}") properties);

  toKvantumConf = attrs:
    concatStringsSep "\n" (
      mapAttrsToList (group: properties: "[${group}]\n${toConfProperty properties}") attrs
    );
in {
  inherit toConfProperty toKvantumConf;
}
