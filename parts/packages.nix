{
  lib,
  self,
  pins,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (lib.filesystem) packagesFromDirectoryRecursive;
    inherit (lib) callPackageWith;

    callPackage = callPackageWith (pkgs // {inherit self pins;});
  in {
    packages = packagesFromDirectoryRecursive {
      inherit callPackage;
      directory = ./pkgs;
    };
  };
}
