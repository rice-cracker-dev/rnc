{pkgs, ...}: let
  catppuccinKde = pkgs.catppuccin-kde.override {
    flavour = ["macchiato"];
    accents = ["mauve"];
  };
in {
  home.packages = with pkgs; [
    qt6.qtwayland
    qt6.qtsvg # needed to load breeze icons
    kdePackages.breeze
    kdePackages.qqc2-desktop-style
  ];

  xdg.configFile = let
    qtctConf = ''
      [Appearance]
      color_scheme_path=${catppuccinKde}/share/color-schemes/CatppuccinMacchiatoMauve.colors
      custom_palette=true
      icon_theme=Papirus-Dark
      standard_dialogs=xdgdesktopportal
      style=Breeze

      [Fonts]
      fixed="JetBrains Mono,12,-1,5,50,0,0,0,0,0,Regular"
      general="Noto Sans,12,-1,5,50,0,0,0,0,0,Regular"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=1
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=@Invalid()
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=3
    '';
  in {
    "qt6ct/qt6ct.conf".text = qtctConf;
    "qt5ct/qt5ct.conf".text = qtctConf;
    "kdeglobals".source = "${catppuccinKde}/share/color-schemes/CatppuccinMacchiatoMauve.colors";
  };
}
