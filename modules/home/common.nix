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
    aseprite
    zed-editor
    cemu

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
  ];
}
