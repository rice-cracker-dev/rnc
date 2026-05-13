{
  inputs',
  pkgs,
  ...
}: let
  inherit (pkgs.writers) writeTOML;
  eh = inputs'.eh.packages.default;
in {
  environment.systemPackages = [eh];

  home.rum.programs.nushell.aliases = {
    nir = "eh run";
    nis = "eh shell";
    nib = "eh build";
    nid = "eh develop";
    nii = "eh info";
    niu = "eh update";
  };

  home.xdg.config.files."eh/config.toml".source = writeTOML "eh-config" {
    impure = true;
    commands.build.env.NIXPKGS_ALLOW_UNFREE = "1";
    commands.run.env.NIXPKGS_ALLOW_UNFREE = "1";
  };
}
