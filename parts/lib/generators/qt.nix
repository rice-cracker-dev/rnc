lib: let
  inherit (lib) pipe map concatStringsSep;
in {
  makeQMLPath = deps:
    pipe deps [
      (map (lib: "${lib}/lib/qt-6/qml"))
      (concatStringsSep ":")
    ];
}
