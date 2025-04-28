lib: let
  inherit (lib.lists) map;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.strings) concatStringsSep;

  toKittyConf = attrs:
    concatStringsSep "\n" (
      mapAttrsToList (name: value: "${name} ${value}") attrs
    );

  toKittyIncludes = includes:
    concatStringsSep "\n" (
      map (include: "include ${include}") includes
    );
in {
  inherit toKittyConf toKittyIncludes;
}
