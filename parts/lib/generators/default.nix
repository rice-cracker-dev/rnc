lib: let
  uwsm = import ./uwsm.nix lib;
  btop = import ./btop.nix lib;
  qt = import ./qt.nix lib;
in
  uwsm // btop // qt
