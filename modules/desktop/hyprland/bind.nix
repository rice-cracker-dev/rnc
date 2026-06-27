{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption map concatStringsSep mapAttrsToList flatten range;
  inherit (lib.types) listOf;
  inherit (lib.rnc.dag) entryAfter entryBefore;
  inherit (lib.rnc.hyprland) dispatcher mkHyprlandBind;
  inherit (lib.rnc.types.hyprland) hyprlandBind;

  cfg = config.desktop.hyprland;

  directionBinds =
    flatten
    (mapAttrsToList (direction: key: [
        (mkHyprlandBind "SUPER + ${key}" (dispatcher.focus (cfg.generator {inherit direction;})) {})
        (mkHyprlandBind "SUPER + SHIFT + ${key}" (dispatcher.window.move (cfg.generator {inherit direction;})) {})
      ]) {
        l = "h";
        u = "k";
        d = "j";
        r = "l";
      });

  workspaceBinds = flatten (map (ws: [
    (mkHyprlandBind "SUPER + ${toString ws}" (dispatcher.focus (cfg.generator {workspace = ws;})) {})
    (mkHyprlandBind "SUPER + SHIFT + ${toString ws}" (dispatcher.window.move (cfg.generator {
      workspace = ws;
      follow = true;
    })) {})
  ]) (range 1 9));
in {
  options.desktop.hyprland.bind = mkOption {
    type = listOf hyprlandBind;
    description = "A list of keybind config.";
    default =
      [
        # apps
        (mkHyprlandBind "SUPER + RETURN" (dispatcher.exec_cmd "withUWSM(${cfg.generator "kitty"})") {})
        (mkHyprlandBind "SUPER + SHIFT + C" (dispatcher.exec_cmd "withUWSM(${cfg.generator "hyprpaper -a"})") {})
        (mkHyprlandBind "SUPER + D" (dispatcher.exec_cmd "withUWSM(${cfg.generator "fuzzel"})") {})

        # flameshot
        (mkHyprlandBind "PRINT" (dispatcher.exec_cmd "flameshotExec(${cfg.generator "screen"})") {})
        (mkHyprlandBind "CTRL + PRINT" (dispatcher.exec_cmd "flameshotExec(${cfg.generator "gui"})") {})
        (mkHyprlandBind "ALT + PRINT" "flameshotActiveWindow" {})

        # pipewire
        (mkHyprlandBind "XF86AudioRaiseVolume" (dispatcher.exec_cmd (cfg.generator "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1")) {})
        (mkHyprlandBind "XF86AudioLowerVolume" (dispatcher.exec_cmd (cfg.generator "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1")) {})
        (mkHyprlandBind "XF86AudioMute" (dispatcher.exec_cmd (cfg.generator "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")) {})

        # general binds
        (mkHyprlandBind "SUPER + M" (dispatcher.exec_cmd (cfg.generator "uwsm stop")) {})
        (mkHyprlandBind "SUPER + W" "hl.dsp.window.close()" {})
        (mkHyprlandBind "SUPER + P" "hl.dsp.window.pin()" {})
        (mkHyprlandBind "SUPER + V" "hl.dsp.window.float()" {})
        (mkHyprlandBind "SUPER + F" "hl.dsp.window.fullscreen()" {})

        (mkHyprlandBind "SUPER + mouse:272" "hl.dsp.window.drag()" {mouse = true;})
        (mkHyprlandBind "SUPER + mouse:273" "hl.dsp.window.resize()" {mouse = true;})
      ]
      ++ directionBinds ++ workspaceBinds;
  };

  config.desktop.hyprland.luaConfig = {
    bind-function = entryBefore ["bind"] ''
      local function withUWSM(cmd)
      	return "uwsm app -- " .. cmd
      end

      local function flameshotExec(cmd)
      	return string.format("flameshot %s -r -p ~/Pictures/ | wl-copy", cmd)
      end

      local function flameshotActiveWindow()
        local window = hl.get_active_window()
        if window == nil then
          return
        end

        local region = string.format('"%dx%d+%d+%d"', window.size.x, window.size.y, window.at.x, window.at.y)
        hl.dispatch(hl.dsp.exec_cmd(flameshotExec("gui --region " .. region)))
      end
    '';

    bind = entryAfter ["config"] (concatStringsSep "\n" (map (bind: "hl.bind(${cfg.generator bind.key}, ${bind.action},${cfg.generator bind.flag})") cfg.bind));
  };
}
