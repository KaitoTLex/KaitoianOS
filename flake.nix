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
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
    };
    hyprscroller-src = {
      url = "github:cpiber/hyprscroller";
      flake = false;
    };
    jkernel = {
      url = "github:tweag/jupyenv";
      flake = false;
    };
    iamb = {
      url = "github:ulyssa/iamb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      lanzaboote,
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
          lanzaboote.nixosModules.lanzaboote

          (
            { pkgs, lib, ... }:
            {

              environment.systemPackages = [
                # For debugging and troubleshooting Secure Boot.
                pkgs.sbctl
              ];

              # Lanzaboote currently replaces the systemd-boot module.
              # This setting is usually set to true in configuration.nix
              # generated at installation time. So we force it to false
              # for now.
              boot.loader.systemd-boot.enable = lib.mkForce false;

              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
              };
            }
          )
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
                      "DP-1, 1920x1080@75.03,3840x0,1,transform, 1"
                      "HDMI-A-1,1920x1080@165,1920x0,1"
                    ];
                    programs.git.signing = {
                      signByDefault = true;
                      key = "42F52D76F1B15B8D997E2AEE8AB934746F475D0B";
                    };
                  }
                ];
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
          lanzaboote.nixosModules.lanzaboote

          (
            { pkgs, lib, ... }:
            {

              environment.systemPackages = [
                # For debugging and troubleshooting Secure Boot.
                pkgs.sbctl
              ];

              # Lanzaboote currently replaces the systemd-boot module.
              # This setting is usually set to true in configuration.nix
              # generated at installation time. So we force it to false
              # for now.
              boot.loader.systemd-boot.enable = lib.mkForce false;

              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
              };
            }
          )
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
                    programs.git.signing = {
                      signByDefault = true;
                      key = "BC04C0C14AEDA705B8FBACE8C5F52A3C0F3B4A77";
                    };
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
