{inputs, username, ...}: {
  imports = [inputs.home-manager.nixosModules.default];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs username;
    };
    backupFileExtension = "hm.bck";
    useGlobalPkgs = true;
  };
}
