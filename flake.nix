{
  description = "rice nix config";

  outputs = {flake-parts, ...} @ inputs: let
    lib = import ./lib/stdlib-extended.nix {inherit inputs;};
  in
    flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = {inherit lib;};
    } {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
      imports = [./parts ./modules ./hosts];
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    ricevim.url = "github:rice-cracker-dev/ricevim";
    nh.url = "github:nix-community/nh/v4.4.0-beta1";
    hyprland.url = "github:hyprwm/Hyprland";
    ragenix.url = "github:ryantm/agenix";
    niri.url = "github:sodiboo/niri-flake";
    eh.url = "github:NotAShelf/eh";
    nixos-core.url = "github:feel-co/nixos-core/v1.0.1";
    ncro.url = "github:feel-co/ncro/v2.2.2";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };

    qtengine = {
      url = "github:kossLAN/qtengine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
