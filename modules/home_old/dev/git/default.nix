{
  imports = [
    ./gh.nix
    ./lazygit.nix
  ];

  programs.git.enable = true;

  programs.git.extraConfig = {
    user = {
      name = "rice-cracker-dev";
      email = "ricecracker2234@proton.me";
    };
  };
}
