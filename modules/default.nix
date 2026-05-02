{
  self,
  lib,
  ...
}: let
  inherit (lib) filter hasPrefix;
  inherit (self.lib.filesystem) listNixFilesRecursively;
in {
  flake.nixosModules.default = {
    imports = filter (path: let
      filename = baseNameOf path;

      # prevent this file from getting imported
      conditions = path != ./default.nix && (!(hasPrefix "_" filename));
    in
      conditions) (listNixFilesRecursively ./.);
  };
}
