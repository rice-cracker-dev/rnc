{pkgs, ...}: {
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    channel.enable = false;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      warn-dirty = false;
      allow-import-from-derivation = false;
      use-xdg-base-directories = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
    permittedInsecurePackages = ["olm-3.2.16"];
  };
}
