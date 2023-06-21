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

    helix.url = "github:rozaliev/helix/jump-rebase";
    
    
  };

  outputs = inputs@ { nixpkgs, home-manager, nurpkgs, darwin, mkAlias, ... }:
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
              ];


            }
        ];
      };

    
      # defaultPackage.${system} = home-manager.defaultPackage.${system};
      # homeConfigurations."erz" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;

      #   # Specify your home configuration modules here, for example,
      #   # the path to your home.nix.
      #   modules = [ 
      #     {
      #         nixpkgs = {
      #           config = {
      #             allowUnfree = true;
      #             allowUnfreePredicate = (_: true);
      #           };
      #         };
      #       } {
      #         nixpkgs.config.allowUnfree = true;
      #       }

      #      ./home.nix 

      #       nurpkgs.nixosModules.nur
      #       {
      #           nixpkgs.overlays = [
      #             nurpkgs.overlay
      #           ];

      #       }
      #   ];

      #   # Optionally use extraSpecialArgs
      #   # to pass through arguments to home.nix
      # };
    };
}
