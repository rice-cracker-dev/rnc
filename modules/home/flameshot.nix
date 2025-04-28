{pkgs, ...}: {
  config.me = {
    packages = [
      (pkgs.flameshot.override {
        enableWlrSupport = true;
      })
    ];

    rum.programs.hyprland.settings = {
      windowrulev2 = [
        "noanim, class:(flameshot)"
        "move 0 0, class:(flameshot)"
        "pin, class:(flameshot)"
        "fullscreenstate, class:(flameshot)"
        "float, class:(flameshot)"
      ];

      bind = [
        ", print, exec, flameshot screen -c"
        "ctrl, print, exec, flameshot gui -c"
      ];
    };
  };
}
