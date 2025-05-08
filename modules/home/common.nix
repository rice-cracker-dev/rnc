{pkgs, ...}: {
  config.me.packages = with pkgs; [
    # others
    wl-clipboard
    brightnessctl
    transmission_4-qt
    mpv
    telegram-desktop
    (discord.override {
      withVencord = true;
    })
    (brave.override {
      commandLineArgs = "--password-store=gnome-libsecret";
    })

    # fonts
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    jetbrains-mono

    # games
    prismlauncher
    lunar-client

    # tools
    hurl
  ];
}
