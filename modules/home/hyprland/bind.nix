{lib, ...}: let
  workspaceBinds = builtins.concatMap (w: let
    ws = toString w;
  in [
    "super, ${ws}, workspace, ${ws}"
    "super shift, ${ws}, movetoworkspace, ${ws}"
  ]) (lib.range 1 9);
in {
  config.me.rum.programs.hyprland.settings = {
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
        "super, j, togglefloating"
        "super, f, fullscreen"
      ]
      ++ workspaceBinds;

    bindm = [
      "super, mouse:272, movewindow"
      "super, mouse:273, resizewindow"
    ];

    binde = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];
  };
}
