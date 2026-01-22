lib: let
  inherit (lib) mapAttrsToList concatStringsSep;

  toUWSM = attrs: concatStringsSep "\n" (mapAttrsToList (k: v: "export ${k}=${toString v}") attrs);
  withUWSM = exec: "uwsm app -- ${exec}";
in {
  inherit toUWSM withUWSM;
}
