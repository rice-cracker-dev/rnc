{
  pkgs,
  lib,
  config,
  ...
}: {
  config.home.font = lib.mkIf (config.configs == "fantasy") {
    enable = true;

    packages = with pkgs; [
      monocraft
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
    ];

    emoji = "Noto Color Emoji";
    monospace = "Monocraft";
    sansSerif = "Noto Sans";
    serif = "Noto Serif";
  };
}
