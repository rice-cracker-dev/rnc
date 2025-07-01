lib: let
  inherit (lib.types) oneOf str bool int float path listOf attrsOf;

  confType = oneOf [str bool int float];
  tomlType = oneOf [
    bool
    int
    float
    str
    path
    (attrsOf tomlType)
    (listOf tomlType)
  ];
in {
  inherit confType tomlType;
}
