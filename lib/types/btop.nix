{lib}: let
  inherit (lib.types) oneOf str bool number;
in {
  btopThemeValue = oneOf [str bool number];
}
