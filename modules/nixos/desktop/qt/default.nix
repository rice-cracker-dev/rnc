{pkgs, lib, ...}: {
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  environment.systemPackages = with pkgs; [qt6.qtdeclarative];

  nixpkgs.overlays = [(final: prev: {
    qt6Packages = prev.qt6Packages.overrideScope (qfinal: qprev: {
      qt6ct = qprev.qt6ct.overrideAttrs (ctprev: {
        src = pkgs.fetchFromGitHub {
          owner = "ilya-fedin";
          repo = "qt6ct";
          rev = "26b539af69cf997c6878d41ba75ad7060b20e56e";
          sha256 = "sha256-ePY+BEpEcAq11+pUMjQ4XG358x3bXFQWwI1UAi+KmLo=";
        };

        nativeBuildInputs = (builtins.filter (p: p != qfinal.qmake) ctprev.nativeBuildInputs) ++ [ final.cmake ];

        buildInputs = ctprev.buildInputs ++ (with final.kdePackages; [
          kconfig
          kcolorscheme
          kiconthemes
        ]);

        cmakeFlags = [
          (lib.cmakeFeature "PLUGINDIR" "lib/qt-6/plugins")
        ];
      });
    });
  })];
}
