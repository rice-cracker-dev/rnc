{inputs, pkgs, ...}: {
  home.packages = [
    inputs.ags.packages.${pkgs.system}.agsFull
  ];

  programs.ags = {
    enable = false;
    
    configDir = ./config;

    extraPackages = [
      inputs.ags.packages.${pkgs.system}.agsFull
    ];
  };
}
