{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.home = mkIf desktop.enable {
    packages = with pkgs; [
      wl-clipboard
      brightnessctl
      qbittorrent
      mpv
      zed-editor-fhs
      libreoffice
      postman
      bruno
      ani-cli
      gpu-screen-recorder
      scrcpy
      legcord
      (discord.override {withEquicord = true;})
      (bottles.override {removeWarningPopup = true;})
      antigravity-fhs # slop
      brave

      # cli
      android-tools
    ];
  };
}
