{inputs, ...}: {
  imports = [
    ./configs
    ./desktop
    ./dev
    ./home
    ./os
    ./virtualisation
  ];

  nixpkgs.overlays = [
    (import "${inputs.self}/overlays" {inherit inputs;})
  ];
}
