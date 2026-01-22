{
  lib,
  self,
  config,
  ...
}: let
  inherit (lib) range mkIf;
  inherit (self.lib.generators) withUWSM;

  cfg = config.desktop.hyprland;

  workspaceBinds = builtins.concatMap (w: let
    ws = toString w;
  in [
    "super, ${ws}, workspace, ${ws}"
    "super shift, ${ws}, movetoworkspace, ${ws}"
  ]) (range 1 9);
in {
  config.home.rum.desktops.hyprland.settings = mkIf cfg.enable {
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

        # apps
        "super, return, exec, ${withUWSM "kitty"}"
        "super shift, c, exec, ${withUWSM "hyprpicker -a"}"
        "super, d, exec, ${withUWSM "fuzzel"}"
      ]
      ++ workspaceBinds;

    bindm = [
      "super, mouse:272, movewindow"
      "super, mouse:273, resizewindow"
    ];

    binde = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];
  };
}
