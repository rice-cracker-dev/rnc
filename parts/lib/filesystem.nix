lib: let
  inherit (lib) mapAttrsToList filterAttrs filter hasSuffix;
  inherit (lib.filesystem) listFilesRecursive;

  getDirectoryNames = basePath: mapAttrsToList (path: _: path) (filterAttrs (p: t: t == "directory") (builtins.readDir basePath));
  listNixFilesRecursively = basePath: filter (path: hasSuffix ".nix" path) (listFilesRecursive basePath);
in {
  inherit getDirectoryNames listNixFilesRecursively;
}
