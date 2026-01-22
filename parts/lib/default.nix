{lib, ...}: {
  flake.lib = {
    filesystem = import ./filesystem.nix lib;
    types = import ./types.nix lib;
    generators = import ./generators lib;
  };
}
