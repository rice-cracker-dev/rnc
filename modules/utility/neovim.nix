{inputs', ...}: {
  config = {
    environment = {
      systemPackages = [inputs'.ricevim.packages.default];
      sessionVariables.EDITOR = "nvim";
    };
  };
}
