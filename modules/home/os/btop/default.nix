{inputs, ...}: {
  xdg.configFile."btop/themes/catppuccin_macchiato.theme".source = "${inputs.catppuccin-btop}/themes/catppuccin_macchiato.theme";

  programs.btop = {
    enable = true;

    settings = {
      color_theme = "catppuccin_macchiato";
      theme_background = false;
    };
  };
}
