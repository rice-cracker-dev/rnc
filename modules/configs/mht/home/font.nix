{pkgs, ...}: {
  config.home.font = {
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
    ];

    emoji = ["Noto Color Emoji"];
    monospace = ["JetBrains Mono"];
    sansSerif = ["Noto Sans"];
    serif = ["Noto Serif"];
  };
}
