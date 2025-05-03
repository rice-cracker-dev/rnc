{pkgs, ...}: {
  config.me.packages = with pkgs; [
    # others
    wl-clipboard
    brightnessctl
    brave
    transmission_4
    mpv
    (discord.override {
      withVencord = true;
    })

    # fonts
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    jetbrains-mono

    # games
    prismlauncher

    # tools
    hurl
  ];
}
