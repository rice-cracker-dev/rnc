{
  _module.args = {
    pins = import ../npins;
  };

  imports = [
    ./lib
    ./quickshell
    ./devshells.nix
    ./packages.nix
  ];
}
