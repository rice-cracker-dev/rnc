{pkgs, ...}: {
  config = {
    home.packages = [
      (pkgs.discord.override {
        withVencord = true;
      })
    ];

    home.hyprland.settings.bind = [
      "super, q, pass, class:^(discord)$"
    ];
  };
}
