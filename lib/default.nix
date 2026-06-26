{lib, ...}: {
  types = import ./types {inherit lib;};
  generators = import ./generators {inherit lib;};
  filesystem = import ./filesystem.nix {inherit lib;};
  dag = import ./dag.nix {inherit lib;};
}
