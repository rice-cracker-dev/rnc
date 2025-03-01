{
  inputs,
  username,
  ...
}: {
  imports = [
    "${inputs.self}/modules/home"
    "${inputs.self}/modules/themes/mht/home"
    ./modules/home
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
