{
  description = "s-mil nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    nixpkgs-unstable.url =
      "github:NixOS/nixpkgs/nixos-unstable"; # also see 'unstable-packages' overlay at 'overlays/default.nix"

    hardware.url = "github:nixos/nixos-hardware";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-23.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    # hyprland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    nix-colors.url = "github:misterio77/nix-colors";

    nix-gaming.url = "github:fufexan/nix-gaming";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake.url = "github:xremap/nix-flake";

    # # Personal
    # nix-secrets = {
    #   url = "git+ssh://git@github.com/s-mil/nix-secrets.git?ref=main&shallow=1";
    #   flake = false;
    # };

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

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      system = "x86_64-linux";
      inherit (nixpkgs) lib;
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      # overlays = (_: prev: {
      #   tailscale = unstable.tailscale;
      #   steam = unstable.steam;
      #   proton-ge-bin = unstable.proton-ge-bin;
      # });
      configVars = import ./vars { inherit inputs lib; };
      configLib = import ./lib { inherit lib; };
      specialArgs = {
        inherit inputs outputs configVars configLib nixpkgs unstable;
      };
    in {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      # Custom modifications/overrides to upstream packages.
      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = {
        #####################################################
        # --------------------- ODIN -----------------------#
        #####################################################
        odin = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/odin
          ];
        };
        #####################################################
        # --------------------- Freya -----------------------#
        #####################################################
        freya = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/freya
          ];
        };

        #####################################################
        # --------------------- THOR -----------------------#
        #####################################################
        thor = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/thor
            inputs.stylix.nixosModules.stylix
          ];
        };

      };

    };
}
