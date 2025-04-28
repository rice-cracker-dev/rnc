{pkgs, ...}: {
  config.home.packages = with pkgs; [
    kdePackages.dolphin
    wl-clipboard
    brightnessctl
    brave
    transmission
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
