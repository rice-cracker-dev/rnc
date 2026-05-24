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

      # monkey patch
      # TODO: remove this when https://github.com/NixOS/nixpkgs/issues/514113 is fixed
      (_: prev: {
        openldap = prev.openldap.overrideAttrs {
          doCheck = !prev.stdenv.hostPlatform.isi686;
        };
      })
    ];

    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };

  programs.nix-ld.enable = true;
}
