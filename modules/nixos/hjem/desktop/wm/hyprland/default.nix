{pkgs, ...}: {
  imports = [
    ./animation.nix
    ./bind.nix
    ./input.nix
    ./windowrule.nix
  ];

  environment.systemPackages = [pkgs.brightnessctl];

  config.rum.programs.hyprland = {
    enable = true;
  };
}
