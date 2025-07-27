{
  pkgs,
  inputs,
  ...
}: {
  config.me.packages = with pkgs; [
    # others
    wl-clipboard
    brightnessctl
    qbittorrent
    mpv
    inputs.zen-browser.packages.${pkgs.system}.beta
    blender_4_5
    vesktop

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
