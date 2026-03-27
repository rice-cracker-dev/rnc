self: {
  _module.args = {
    pins = import ../npins;
    overlays = import ./overlays self;
  };

  imports = [
    ./lib
    ./quickshell
    ./devshells.nix
    ./packages.nix
  ];
}
