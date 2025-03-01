{pkgs, ...}: {
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      emoji = ["Noto Color Emoji"];
      monospace = ["JetBrains Mono"];
      sansSerif = ["Noto Sans"];
      serif = ["Noto Serif"];
    };
  };
}
