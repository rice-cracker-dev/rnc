{inputs', ...}: let
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
}
