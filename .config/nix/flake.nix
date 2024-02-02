{
  description = "Home Manager configuration of erz";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nurpkgs.url = github:nix-community/NUR;
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    mkAlias = {
      url = "github:reckenrode/mkAlias";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scls = {
      url = "github:estin/simple-completion-language-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-jump = {
      url = "github:pascalkuthe/helix?ref=amp-jump";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@ { nixpkgs, home-manager, nurpkgs, darwin, mkAlias, scls, helix-jump, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

    in {
      darwinConfigurations."erz-mbp" = darwin.lib.darwinSystem {
        inherit system inputs;
        modules = [
            ./configuration.nix
            home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = { inherit inputs system;};
              # home-manager.useUserPackages = true;
              home-manager.users.erz = import ./home.nix;
 
              
              nixpkgs.overlays = [
                nurpkgs.overlay
                (_: _: { helix-jump = helix-jump.packages.${system}.default; })
              ];

            }
        ];
      };
    };
}
