{pkgs, ...}: {
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    channel.enable = false;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      warn-dirty = false;
      allow-import-from-derivation = false;
      use-xdg-base-directories = true;
    };
  };

  nixpkgs = {
    overlays = [
      (final: prev: {
        inherit (prev.lixPackageSets.stable) nixpkgs-review nix-eval-jobs nix-fast-build colmena;
      })
    ];

    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };

  programs.nix-ld.enable = true;
}
