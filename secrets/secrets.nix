let
  keys = import ./keys.nix;

  allKeys = keys.systems ++ keys.users;
in {
  "aronaldo.age".publicKeys = allKeys;
  "tailscale-key.age".publicKeys = allKeys;
}
