{
  self,
  inputs,
  withSystem,
  lib,
  pins,
  overlays,
  ...
}: let
  inherit (lib) listToAttrs concatLists map;
  inherit (self.lib.filesystem) getDirectoryNames;

  mkSystem = hostName: system:
    withSystem system ({
      inputs',
      self',
      ...
    }:
      lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs inputs' self self' hostName pins;
        };

        modules = [
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
