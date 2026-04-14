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
        packages = [
          npins
          inputs'.ragenix.packages.default
        ];
      };
    };
  };
}
