{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.configs == "fantasy") {
    me.rum.programs.hyprland.settings.bind = [
      "super, d, exec, qs ipc call launcher toggle"
    ];

    home.quickshell = {
      enable = true;
      configDir = ./config;
    };
  };
}
