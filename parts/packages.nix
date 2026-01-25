{
  lib,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (lib.filesystem) packagesFromDirectoryRecursive;
    inherit (lib) callPackageWith;

    callPackage = callPackageWith (pkgs // {inherit self;});
  in {
    packages = packagesFromDirectoryRecursive {
      inherit callPackage;
      directory = ./pkgs;
    };
  };
}
