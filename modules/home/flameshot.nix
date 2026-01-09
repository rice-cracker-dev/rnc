{
  pkgs,
  lib,
  config,
  ...
}: {
  config.me = lib.mkIf config.enableDesktopModules {
    packages = [
      (pkgs.flameshot.override {
        enableWlrSupport = true;
      })
    ];

    xdg.config.files."flameshot/flameshot.ini".text = ''
      [General]
      saveAfterCopy=true
      useGrimAdapter=true
    '';

    rum.desktops.hyprland.settings = {
      windowrule = [
        "no_anim on, match:title flameshot"
        "move 0 0, match:title flameshot"
        "pin on, match:title flameshot"
        "fullscreen_state 2, match:title flameshot"
        "float on, match:title flameshot"
      ];

      bind = [
        ", print, exec, flameshot screen -c"
        "ctrl, print, exec, flameshot gui -c"
      ];
    };
  };
}
