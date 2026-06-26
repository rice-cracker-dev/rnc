{lib, ...}: {
  filesystem = import ./filesystem.nix {inherit lib;};
  types = import ./types.nix {inherit lib;};
  generators = import ./generators {inherit lib;};
}
