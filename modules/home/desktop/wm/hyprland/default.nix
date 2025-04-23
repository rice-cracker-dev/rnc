{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./animation.nix
    ./bind.nix
    ./input.nix
    ./windowrule.nix
  ];

  config = {
    environment.systemPackages = [pkgs.brightnessctl];

    hjem.users.${username}.rum.programs.hyprland = {
      enable = true;
    };
  };
}
