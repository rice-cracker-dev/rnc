{
  _module.args = {
    pins = import ../npins;
    overlays = import ./overlays;
  };

  imports = [
    ./lib
    ./quickshell
    ./devshells.nix
    ./packages.nix
  ];
}
