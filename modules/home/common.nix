{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  desktopPackages = with pkgs; [
    wl-clipboard
    brightnessctl
    qbittorrent
    mpv
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.helium
    blender_4_5
    kdePackages.kdenlive
    (discord.override {withEquicord = true;})
    zed-editor
    libreoffice

    # fonts
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    jetbrains-mono

    # tools
    postman
    dbeaver-bin
    webcamoid
    ani-cli
    gpu-screen-recorder
  ];
in {
  config.me.packages = with pkgs;
    [
      # tools
      hurl
      uv
      ngrok
      wireguard-tools
      parted
      gemini-cli
    ]
    ++ (lib.optionals config.enableDesktopModules desktopPackages);
}
