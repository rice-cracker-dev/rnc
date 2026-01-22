lib: let
  inherit (lib) isString isBool concatStringsSep mapAttrsToList;

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
  inherit toBtopConf toBtopValue;
}
