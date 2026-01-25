{
  perSystem = {pkgs, ...}: let
    inherit (pkgs) mkShell npins;
  in {
    devShells = {
      default = mkShell {
        buildInputs = [npins];
      };
    };
  };
}
