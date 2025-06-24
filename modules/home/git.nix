{
  pkgs,
  lib,
  ...
}: {
  config.me = {
    packages = with pkgs; [gh lazygit];

    rum.programs.git = {
      enable = true;

      settings = {
        # taken from home-manager
        # https://github.com/nix-community/home-manager/blob/release-25.05/modules/programs/gh.nix
        credential = builtins.listToAttrs (
          map (
            host:
              lib.nameValuePair host {
                helper = "${pkgs.gh}/bin/gh auth git-credential";
              }
          )
          [
            "https://github.com"
            "https://gist.github.com"
          ]
        );
      };
    };
  };
}
