{
  lib,
  riceLib,
  config,
  ...
}: let
  inherit (lib) range mkOption;
  inherit (lib.lists) map filter;
  inherit (lib.attrsets) attrsToList;
  inherit (lib.types) submodule nullOr str;
  inherit (riceLib.generators) toUWSM;

  cfg = config.home.hyprland.binds;

  hyprlandKey = submodule {
    options = {
      modifiers = mkOption {type = str;};
      key = mkOption {type = str;};
    };
  };

  mkHyprlandBindOption = modifiers: key: {
    bind = mkOption {
      type = hyprlandKey;
      default = {inherit modifiers key;};
    };
    exec = mkOption {type = nullOr str;};
  };

  programBinds =
    map
    (bind: "${bind.value.bind.modifiers}, ${bind.value.bind.key}, exec, ${toUWSM bind.value.exec}")
    (filter (bind: bind.value.exec != null) (attrsToList cfg.programs));

  workspaceBinds = builtins.concatMap (w: let
    ws = toString w;
  in [
    "super, ${ws}, workspace, ${ws}"
    "super shift, ${ws}, movetoworkspace, ${ws}"
  ]) (range 1 9);
in {
  options.home.hyprland.binds = {
    programs = {
      terminal = mkHyprlandBindOption "super" "return";
    };
  };

  config.me.rum.desktops.hyprland.settings = {
    bind =
      [
        "super, m, exec, uwsm stop"
        "super, w, killactive"

        "super, left, movefocus, l"
        "super, right, movefocus, r"
        "super, up, movefocus, u"
        "super, down, movefocus, d"

        "super ctrl, up, movewindow, u"
        "super ctrl, down, movewindow, d"
        "super ctrl, left, movewindow, l"
        "super ctrl, right, movewindow, r"

        "super, p, pin, active"
        "super, v, togglefloating"
        "super, f, fullscreen"
      ]
      ++ workspaceBinds
      ++ programBinds;

    bindm = [
      "super, mouse:272, movewindow"
      "super, mouse:273, resizewindow"
    ];

    binde = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];
  };
}
