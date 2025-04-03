{pkgs, ...}: {
  imports = [
    ./animation.nix
    ./bind.nix
    ./input.nix
    ./windowrule.nix
  ];

  home.packages = [pkgs.brightnessctl];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
  };
}
