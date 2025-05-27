{
  pkgs,
  inputs,
  ...
}: {
  config = {
    me.packages = [inputs.nvf-config.packages.${pkgs.system}.default];

    home.uwsm.env = {
      EDITOR = "nvim";
    };
  };
}
