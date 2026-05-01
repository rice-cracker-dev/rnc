{
  self,
  inputs,
  withSystem,
  lib,
  pins,
  overlays,
  ...
}: let
  inherit (lib) listToAttrs concatLists map nixosSystem;
  inherit (self.lib.filesystem) getDirectoryNames;

  mkSystem = hostName: system:
    withSystem system ({
      inputs',
      self',
      ...
    }:
      nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs inputs' self self' hostName pins;
        };

        modules = [
          inputs.ragenix.nixosModules.default
          inputs.lanzaboote.nixosModules.lanzaboote
          self.nixosModules.default
          ./${system}/${hostName}
          {nixpkgs.overlays = overlays;}
        ];
      });

  mkSystems = system: path: let
    hostNames = getDirectoryNames path;
  in
    map (hostName: {
      name = hostName;
      value = mkSystem hostName system;
    })
    hostNames;

  nixosConfigurations = listToAttrs (concatLists (map (system: mkSystems system ./${system}) (getDirectoryNames ./.)));
in {
  flake = {inherit nixosConfigurations;};
}
