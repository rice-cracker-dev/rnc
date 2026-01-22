{inputs', ...}: {
  config = {
    home.packages = [inputs'.ricevim.packages.default];
    desktop.uwsm.defaultEnv.EDITOR = "nvim";
  };
}
