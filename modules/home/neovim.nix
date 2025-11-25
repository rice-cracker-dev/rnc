{
  pkgs,
  inputs,
  ...
}: {
  config = {
    me.packages = [inputs.nvf-config.packages.${pkgs.stdenv.hostPlatform.system}.default];

    home.uwsm.env = {
      EDITOR = "nvim";
    };
  };
}
