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
      (discord.override {withEquicord = true;})
      zed-editor-fhs
      libreoffice
      postman
      bruno
      ani-cli
      gpu-screen-recorder
      scrcpy
    ];
  };
}
