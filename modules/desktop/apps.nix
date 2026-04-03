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
      brave
      element-desktop
      (bottles.override {removeWarningPopup = true;})
      equibop
      # too buggy for usage
      # (discord.override {
      #   withEquicord = true;
      #   withOpenASAR = true;
      # })

      # cli
      android-tools
    ];
  };
}
