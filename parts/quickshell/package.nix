# yoinked from https://github.com/Rexcrazy804/Zaphkiel/blob/master/users/Wrappers/quickshell.nix
{
  symlinkJoin,
  makeWrapper,
  quickshell,
  makeFontsConf,
  lib,
  self,
  configDir,
  qtPackages ? [],
  fontPackages ? [],
  extraPackages ? [],
}: let
  inherit (lib) makeBinPath;
  inherit (self.lib.generators) makeQMLPath;

  fontconfig = makeFontsConf {
    fontDirectories = fontPackages;
  };
in
  symlinkJoin {
    name = "quickshell-wrapper";
    paths = [quickshell];

    buildInputs = [makeWrapper];

    postBuild = ''
      wrapProgram $out/bin/quickshell \
        --set FONTCONFIG_FILE "${fontconfig}" \
        --set QML2_IMPORT_PATH "${makeQMLPath qtPackages}" \
        --add-flags "-p ${configDir}" \
        --prefix PATH : ${makeBinPath extraPackages}
    '';

    meta.mainProgram = "quickshell";
  }
