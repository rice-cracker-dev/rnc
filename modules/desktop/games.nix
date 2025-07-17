{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.aagl.nixosModules.default];

  nix.settings = {
    substituters = ["https://ezkea.cachix.org"];
    trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
  };

  programs.sleepy-launcher.enable = true;

  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}
