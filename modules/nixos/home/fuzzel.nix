{inputs, ...}: let
  uwsm = import "${inputs.self}/lib/uwsm.nix";
in {
  config.home.rum.programs = {
    fuzzel = {
      enable = true;
      settings = {
        main.launch-prefix = "uwsm app -- ";
      };
    };

    hyprland.settings.bind = [
      "super, d, exec, ${uwsm.useUWSM "fuzzel"}"
    ];
  };
}
