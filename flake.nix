{
  description = "s-mil nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Utils
    nix-colors.url = "github:misterio77/nix-colors";

    nix-gaming.url = "github:fufexan/nix-gaming";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    sops-nix.url = "github:Mic92/sops-nix";

    xremap-flake.url = "github:xremap/nix-flake";

    # Personal
    mysecrets = {
      url = "git+ssh://git@github.com/s-mil/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };

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

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware
    , nix-gaming, vscode-server, sops-nix, self, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      overlays = (_: prev: {
        tailscale = unstable.tailscale;
        steam = unstable.steam;
        proton-ge-bin = unstable.proton-ge-bin;
      });
      configVars = import ./vars { inherit inputs lib; };
      configLib = import ./lib { inherit lib; };
      specialArgs = {
        inherit nixos-hardware nix-gaming system inputs outputs unstable;
      };
    in {

      nixosConfigurations = {
        #####################################################
        # --------------------- ODIN -----------------------#
        #####################################################
        odin = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
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
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
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
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/thor
          ];
        };

        #####################################################
        # -------------------- MJOLNIR ---------------------#
        #####################################################
        # mjolnir = nixpkgs.lib.nixosSystem {
        #   inherit system specialArgs;
        #   modules = [
        #     ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
        #     home-manager.nixosModules.home-manager
        #     { home-manager.extraSpecialArgs = specialArgs; }
        #     vscode-server.nixosModules.default
        #     ./common.nix
        #     ./devices/mjolnir.nix
        #     ./devices/hardware-configurations/mjolnir.nix
        #   ];
        # };

      };

    };
}
