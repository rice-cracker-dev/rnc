{pkgs, ...}: {
  home.pointerCursor = let 
    cursorSize = 24;
  in {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = cursorSize;

    gtk.enable = true;
    x11.enable = true;

    hyprcursor = {
      enable = true;
      size = cursorSize;
    };
  };

  # for QT apps
  home.file.".icons/default/index.theme".text = ''
    [Icon Theme]
    Inherits=Bibata-Modern-Classic
  '';
}
