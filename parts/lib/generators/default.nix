lib: let
  uwsm = import ./uwsm.nix lib;
  btop = import ./btop.nix lib;
in
  uwsm // btop
