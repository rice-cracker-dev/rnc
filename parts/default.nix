self: {
  _module.args = {
    pins = import ../npins;
    overlays = import ./overlays self;
  };

  imports = [
    ./lib.nix
    ./devshells.nix
    ./packages.nix
  ];
}
