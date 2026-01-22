{
  self,
  lib,
  ...
}: let
  inherit (lib) filter;
  inherit (self.lib.filesystem) listNixFilesRecursively;
in {
  flake.nixosModules.default = {
    # prevent this file from getting imported
    imports = filter (path: path != ./default.nix) (listNixFilesRecursively ./.);
  };
}
