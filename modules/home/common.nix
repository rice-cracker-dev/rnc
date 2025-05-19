{pkgs, ...}: {
  config.me.packages = with pkgs; [
    # others
    wl-clipboard
    brightnessctl
    transmission_4-qt
    mpv
    legcord
    nheko
    (brave.override {
      commandLineArgs = "--password-store=gnome";
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
