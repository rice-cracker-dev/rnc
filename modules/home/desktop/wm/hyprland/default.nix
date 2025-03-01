{inputs, pkgs, ...}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./animation.nix
    ./bind.nix
    ./exec-once.nix
    ./input.nix
    ./windowrule.nix
  ];

  home.packages = [pkgs.brightnessctl];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
