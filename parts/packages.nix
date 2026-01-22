{lib, ...}: let
  inherit (lib.filesystem) packagesFromDirectoryRecursive;
in {
  perSystem = {pkgs, ...}: {
    packages = packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./pkgs;
    };
  };
}
