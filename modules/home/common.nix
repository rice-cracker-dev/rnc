{
  pkgs,
  inputs,
  ...
}: {
  config.me.packages = with pkgs; [
    # others
    wl-clipboard
    brightnessctl
    transmission_4-qt
    mpv
    krita
    legcord
    inputs.zen-browser.packages.${pkgs.system}.beta

    # fonts
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    jetbrains-mono

    # tools
    hurl
    uv
    python313Packages.ds4drv
  ];
}
