{lib}: {
  btop = import ./btop.nix {inherit lib;};
  dag = import ./dag.nix {inherit lib;};
  uwsm = import ./uwsm.nix {inherit lib;};
  hyprland = import ./hyprland.nix {inherit lib;};
}
