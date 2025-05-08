lib: let
  inherit (lib) isBool;
  inherit (lib.lists) map isList flatten;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.strings) concatStringsSep isString;

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

  toBtopValue = value:
    if (isString value)
    then "\"${value}\""
    else if (isBool value)
    then
      (
        if value
        then "True"
        else "False"
      )
    else (toString value);

  toBtopConf = attrs:
    concatStringsSep "\n" (
      mapAttrsToList (
        name: value: "${name} = ${toBtopValue value}"
      )
      attrs
    );
in {
  inherit toKittyProperty toKittyConf toKvantumProperty toKvantumConf toUWSM toBtopValue toBtopConf;
}
