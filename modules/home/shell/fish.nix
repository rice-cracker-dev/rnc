{pkgs, ...}: {
  home.packages = with pkgs; [zoxide bat fzf fd];

  config.home.files.".config/fish/config.fish".text = ''
    set fish_greeting

    alias cat="${pkgs.bat}/bin/bat"
    alias ls="${pkgs.fd}/bin/fd"

    ${pkgs.zoxide}/bin/zoxide init fish --cmd cd | source
  '';
}
