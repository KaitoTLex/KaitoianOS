{
  description = "System configuration flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:kaitotlex/vix1";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ucodenix = {
      url = "github:e-tho/ucodenix";
    };
    wallpapers = {
      url = "github:kaitotlex/wallpaper";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations.kuroko = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/kuroko
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
                imports = [
                  ./users/kaitotlex
                  {
                    wayland.windowManager.hyprland.settings.monitor = [
                      "eDP-1,1920x1200@120,0x0,1"
                      "DP-1, 1920x1080@144.04,1920x0,1"
                    ];
                  }
                ];
              };
            };
          }
        ];
      };
      nixosConfigurations.kurokoNightly = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/kurokoNightly

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
