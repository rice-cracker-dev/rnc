{
  perSystem = {
    pkgs,
    inputs',
    ...
  }: let
    inherit (pkgs) mkShell npins;
  in {
    devShells = {
      default = mkShell {
        buildInputs = [npins];
      };

      server = mkShell {
        buildInputs = [npins inputs'.ragenix.packages.default];
      };
    };
  };
}
