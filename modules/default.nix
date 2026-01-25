{
  self,
  lib,
  ...
}: let
  inherit (lib) filter hasPrefix;
  inherit (self.lib.filesystem) listNixFilesRecursively;
in {
  flake.nixosModules.default = {
    # prevent this file from getting imported
    imports = filter (path: let
      filename = baseNameOf path;
      conditions = path != ./default.nix && (!(hasPrefix "_" filename));
    in
      conditions) (listNixFilesRecursively ./.);
  };
}
