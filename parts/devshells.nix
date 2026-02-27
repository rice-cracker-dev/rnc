{
  perSystem = {pkgs, ...}: let
    inherit (pkgs) mkShell npins jq;
  in {
    devShells = {
      default = mkShell {
        buildInputs = [npins jq];
      };
    };
  };
}
