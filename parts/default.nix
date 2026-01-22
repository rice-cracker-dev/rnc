{
  _module.args = {
    pins = import ../npins;
  };

  imports = [
    ./lib
    ./devshells.nix
    ./packages.nix
  ];
}
