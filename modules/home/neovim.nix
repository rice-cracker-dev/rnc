{
  pkgs,
  inputs,
  ...
}: {
  config = {
    me.packages = [inputs.ricevim.packages.${pkgs.stdenv.hostPlatform.system}.default];

    home.uwsm.env = {
      EDITOR = "nvim";
    };
  };
}
