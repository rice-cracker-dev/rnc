{lib}: let
  uwsm = import ./uwsm.nix {inherit lib;};
  btop = import ./btop.nix {inherit lib;};
  qt = import ./qt.nix {inherit lib;};
in
  uwsm // btop // qt
