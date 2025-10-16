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
    vesktop
    zed-editor
    libreoffice

    # fonts
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    jetbrains-mono

    # tools
    hurl
    uv
    ngrok
    wireguard-tools
    easyeffects
    postman
    dbeaver-bin

    # ides
    jetbrains.rider
    jetbrains.webstorm
  ];
}
