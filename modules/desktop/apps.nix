{
  lib,
  config,
  pkgs,
  self',
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
      self'.packages.helium
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
    ];
  };
}
