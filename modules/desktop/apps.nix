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
      onlyoffice-desktopeditors
      postman
      bruno
      ani-cli
      gpu-screen-recorder
      scrcpy
      brave
      element-desktop
      (bottles.override {removeWarningPopup = true;})
      tailscale
      (discord.override {
        withEquicord = true;
      })
    ];
  };
}
