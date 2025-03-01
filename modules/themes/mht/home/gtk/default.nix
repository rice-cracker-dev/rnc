{pkgs, ...}: {
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };

    theme = {
      package = pkgs.kdePackages.breeze-gtk;
      name = "Breeze-Dark";
    };

    gtk3.extraConfig.gtk-xft-rgba = "rgb";
    gtk4.extraConfig.gtk-xft-rgba = "rgb";
  };
}

