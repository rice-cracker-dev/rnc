{pkgs, ...}: {
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override {
      enableWlrSupport = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "noanim, class:(flameshot)"
      "move 0 0, class:(flameshot)"
      "pin, class:(flameshot)"
      "fullscreenstate, class:(flameshot)"
      "float, class:(flameshot)"
    ];

    bind = [
      ", print, exec, XDG_CURRENT_DESKTOP=sway flameshot screen --raw | wl-copy"
      "ctrl, print, exec, XDG_CURRENT_DESKTOP=sway flameshot gui --raw | wl-copy"
    ];
  };
}
