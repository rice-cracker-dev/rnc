{self, ...}: {
  perSystem = {
    inputs',
    pkgs,
    ...
  }: let
    inherit (self.lib.generators) makeQMLPath;
    inherit (pkgs) makeFontsConf callPackage mkShell;

    qtPackages = with pkgs.qt6; [
      qtbase
      qtdeclarative
      qtmultimedia
      pkgs.kdePackages.qqc2-desktop-style
      pkgs.kdePackages.kirigami.passthru.unwrapped
      pkgs.kdePackages.sonnet
    ];

    fontPackages = with pkgs; [
      inter
    ];

    quickshell = callPackage ./package.nix {
      inherit self qtPackages fontPackages;
      quickshell = inputs'.quickshell.packages.default;
      configDir = ./config;
    };
  in {
    packages.quickshell = quickshell;

    devShells.quickshell = mkShell {
      buildInputs = [inputs'.quickshell.packages.default];

      QML2_IMPORT_PATH = makeQMLPath qtPackages;
      FONTCONFIG_FILE = makeFontsConf {
        fontDirectories = fontPackages;
      };
    };
  };
}
