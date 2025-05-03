lib: let
  inherit (lib.lists) map isList flatten;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.strings) concatStringsSep;

  toKittyProperty = name: value: "${name} ${toString value}";

  toKittyConf = attrs:
    concatStringsSep "\n" (
      flatten (
        mapAttrsToList (
          name: value:
            if (isList value)
            then map (v: (toKittyProperty name v)) value
            else [(toKittyProperty name value)]
        )
        attrs
      )
    );

  toKvantumProperty = properties:
    concatStringsSep "\n" (mapAttrsToList (property: value: "${property}=${value}") properties);

  toKvantumConf = attrs:
    concatStringsSep "\n" (
      mapAttrsToList (group: properties: "[${group}]\n${toKvantumProperty properties}") attrs
    );

  toUWSM = exec: "uwsm app -- ${exec}";
in {
  inherit toKittyProperty toKittyConf toKvantumProperty toKvantumConf toUWSM;
}
