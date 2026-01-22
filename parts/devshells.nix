{
  perSystem = {pkgs, ...}: let
    inherit (pkgs) mkShell npins;
  in {
    devShells.default = mkShell {
      packages = [npins];
    };
  };
}
