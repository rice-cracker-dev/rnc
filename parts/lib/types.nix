lib: let
  inherit (lib.types) oneOf str number path bool;
in {
  uwsmValue = oneOf [str number path bool];
  btopThemeValue = oneOf [str bool number];
}
