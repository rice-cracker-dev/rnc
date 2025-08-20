{pkgs, ...}: {
  config.me.packages = with pkgs; [
    # others
    wl-clipboard
    brightnessctl
    qbittorrent
    mpv
    brave
    blender_4_5
    kdePackages.kdenlive
    (discord.override {
      withVencord = true;
    })
    aseprite

    # fonts
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    jetbrains-mono

    # tools
    hurl
    uv
  ];
}
