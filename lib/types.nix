lib: let
  inherit (lib.types) oneOf str bool int float;

  confType = oneOf [str bool int float];
in {
  inherit confType;
}
