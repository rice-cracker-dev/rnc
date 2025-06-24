{
  lib,
  config,
  pkgs,
  ...
}: let
  catppuccinKde = pkgs.catppuccin-kde.override {
    flavour = ["macchiato"];
    accents = ["mauve"];
  };
in {
  config = lib.mkIf (config.configs == "mht") {
    me = {
      packages = [pkgs.darkly pkgs.darkly-qt5];
      files."kdeglobals".source = "${catppuccinKde}/share/color-schemes/CatppuccinMacchiatoMauve.colors";
    };

    home.theme = {
      enable = true;

      gtk = {
        enable = true;
        theme = {
          package = pkgs.magnetic-catppuccin-gtk.override {
            accent = ["purple"];
          };
          name = "Catppuccin-GTK-Purple-Dark";
        };
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders;
      };

      cursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
      };

      qtct = {
        enable = true;
        colorSchemePath = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/Catppuccin-Macchiato.conf";

        qt5.style = "Darkly";
        qt6.style = "Darkly";
      };
    };
  };
}
