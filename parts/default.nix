self: {
  _module.args = {
    pins = import ../npins;
    overlays = import ./overlays self;
  };

  imports = [
    ./lib
    ./devshells.nix
    ./packages.nix
  ];
}
