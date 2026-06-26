{lib}: {
  uwsm = import ./uwsm.nix {inherit lib;};
  btop = import ./btop.nix {inherit lib;};
}
