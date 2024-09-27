{
  description = "System configuration flake.";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:KaitoTLex/neovim-flake";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations.kuroko = nixpkgs.lib.nixosSystem{
	specialArgs = {
	  inherit inputs;
	};
	system= "x86_64-linux";
	modules = [
	  ./hosts/kuroko
		home-manager.nixosModules.home-manager{
			home-manager = {
				useGlobalPkgs = true;
				useUserPackages = true;
				backupFileExtension = "backup";
				extraSpecialArgs = {
					inherit inputs;
				};
				users.kaitotlex = {
					imports = [ ./users/kaitotlex ];
				};
			};
		}
	    ];
	};
      nixosConfigurations.shiroko = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/shiroko
	  
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs;
              };
              users.kaitotlex = {
                imports = [ ./users/kaitotlex ];
              };
            };
          }
        ];
      };
    };
}
