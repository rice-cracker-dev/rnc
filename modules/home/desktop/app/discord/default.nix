{pkgs, ...}: {
  home.packages = [(pkgs.discord.override {
    withVencord = true;
  })];

  wayland.windowManager.hyprland.settings.bind = [
    "super, q, pass, class:^(discord)$"
  ];
}
