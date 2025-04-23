{inputs, pkgs, ...}: let
  uwsm = import "${inputs.self}/lib/uwsm.nix";
in {
  home.packages = [pkgs.brave];

  wayland.windowManager.hyprland.settings.bind = [
    "super, w, exec, ${uwsm.useUWSM "brave-browser.desktop"}"
  ];
}
