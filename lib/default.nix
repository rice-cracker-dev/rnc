{lib, ...}: {
  types = import ./types {inherit lib;};
  generators = import ./generators {inherit lib;};
  filesystem = import ./filesystem.nix {inherit lib;};
  hyprland = import ./hyprland.nix;
  dag = import ./dag.nix {inherit lib;};
}
