let
  keys = import ./keys.nix;

  allKeys = keys.systems ++ keys.users;
in {
  "aronaldo.age".publicKeys = allKeys;
  "cloudflare.age".publicKeys = allKeys;
}
