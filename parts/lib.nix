{lib, ...}: {
  flake.lib = {
    inherit (lib) rnc;
  };
}
