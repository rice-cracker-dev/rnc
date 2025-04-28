{pkgs, ...}: {
  config.home.theme = {
    enable = true;

    gtk = {
      enable = true;
      theme = {
        package = pkgs.kdePackages.breeze-gtk;
        name = "Breeze-Dark";
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

    kvantum = {
      enable = true;

      theme = {
        name = "catppuccin-macchiato-mauve";
        package = pkgs.catppuccin-kvantum.override {
          accent = "mauve";
          variant = "macchiato";
        };
      };
    };
  };
}
