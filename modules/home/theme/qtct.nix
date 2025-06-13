{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) str path;

  cfg = config.home.theme.qtct;
  themeCfg = config.home.theme;
  fontCfg = config.home.font;

  qtctConf = qt: ''
    [Appearance]
    standard_dialogs=default
    style=${qt.style}
    icon_theme=${themeCfg.iconTheme.name}
    color_scheme_path=${cfg.colorSchemePath}
    custom_palette=true

    [Fonts]
    fixed="${fontCfg.monospace},9,-1,2,400,0,0,0,0,0,0,0,0,0,0,1"
    general="${fontCfg.sansSerif},9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

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

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';
in {
  options.home.theme.qtct = {
    enable = mkEnableOption "qtct";

    colorSchemePath = mkOption {
      type = path;
      description = "color scheme path";
    };

    qt5.style = mkOption {
      type = str;
      description = "style name";
    };

    qt6.style = mkOption {
      type = str;
      description = "style name";
    };
  };

  config = mkIf cfg.enable {
    me.files = {
      ".config/qt6ct/qt6ct.conf".text = qtctConf cfg.qt6;
      ".config/qt5ct/qt5ct.conf".text = qtctConf cfg.qt5;
    };

    home.uwsm.env.QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
