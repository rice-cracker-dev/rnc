{config, lib, inputs, ...}: let
  uwsm = import "${inputs.self}/lib/uwsm.nix";
in {
  options.fuzzel = {
    enable = lib.mkEnableOption "enable fuzzel";
  };

  config = lib.mkIf config.fuzzel.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main.launch-prefix = "uwsm app -- ";
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      "super, d, exec, ${uwsm.useUWSM "fuzzel"}"
    ];
  };
}
