{

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/23.11-pre";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    nix-colors.url = "github:misterio77/nix-colors";

     nix-gaming.url = "github:fufexan/nix-gaming";

      # color scheme - catppuccin
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    catppuccin-fcitx5 = {
      url = "github:catppuccin/fcitx5";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    catppuccin-wezterm = {
      url = "github:catppuccin/wezterm";
      flake = false;
    };
    catppuccin-helix = {
      url = "github:catppuccin/helix";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };
    cattppuccin-k9s = {
      url = "github:catppuccin/k9s";
      flake = false;
    };

  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, nix-gaming, self, ... }@inputs : 
   let
      overlays = (_: prev: {
        steam = prev.steam.override {
          extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${
              nix-gaming.packages.${system}.proton-ge
            }'";
        };
      });
      system = "x86_64-linux";
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit nixos-hardware nix-gaming system inputs;
      };


      sithis-modules = [
        ./users/sithis/user.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            users.sithis = import ./users/sithis/user.nix;
            extraSpecialArgs = specialArgs;
          };
        }
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
      ];

  in
  {
    #####################################################
    # --------------------- ODIN -----------------------#
    #####################################################
    nixosConfigurations.odin = nixpkgs.lib.nixosSystem {
       inherit system specialArgs;
        modules = [ 
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
          home-manager.nixosModules.home-manager
          ./common.nix
          ./devices/odin.nix
          ./devices/hardware-configurations/odin.nix
        ];
    };

    #####################################################
    # --------------------- THOR -----------------------#
    #####################################################
    nixosConfigurations.thor = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ 
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-yoga
          home-manager.nixosModules.home-manager
          ./common.nix
          ./devices/thor.nix
          ./devices/hardware-configurations/thor.nix
        ];
    };
  };
}
