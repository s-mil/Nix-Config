{

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    nix-colors.url = "github:misterio77/nix-colors";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

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

  outputs = inputs@{ self
	, nixpkgs, nixpkgs-unstable, 
    	home-manager, nixos-hardware, vscode-server, ... }:  
    let
      inputs = { inherit home-manager nixpkgs nixpkgs-unstable; };

      genPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      nixosSystem = system: hostName: username:
        let
          pkgs = genPkgs system;
        in
          nixpkgs.lib.nixosSystem
          {
            inherit system;
            modules = [
              { _module.args = { unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system}; }; }
              vscode-server.nixosModules.default
              home-manager.nixosModules.home-manager
              # {
              #   networking.hostName = hostName;
              #   home-manager.useGlobalPkgs = true;
              #   home-manager.useUserPackages = true;
              #   home-manager.users.${username} = { imports = [ ./users/${username}/home-manager.nix ]; };
              # }
              ./common.nix
              ./devices/${hostName}.nix
              ./devices/hardware-configurations/${hostName}.nix
	            ./users/${username}/user.nix
            ];
          };

  in
  {
    nixosConfigurations ={
      thor = nixosSystem "x86_64-linux" "thor" "sithis";
      odin = nixosSystem "x86_64-linux" "odin" "sithis";
    };
  };


    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'

    # overlays = {
    #   pkg-sets = (
    #     final: prev: {
    #       unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; };
    #     }
    #   );
    # }


    # nixosConfigurations.mjolnr = nixpkgs.lib.nixosSystem {
    #     system = "x86_64-linux";
    #     specialArgs = { 
    #       inherit inputs;
    #     }; # Pass flake inputs to our config
    #     modules = [ 
    #       home-manager.nixosModules.home-manager
    #       ./common.nix
    #       ./devices/prox.nix
    #       ./devices/hardware-configurations/prox.nix
    #     ];

    # };

    # nixosConfigurations.thor = nixpkgs.lib.nixosSystem {
    #     system = "x86_64-linux";
    #     specialArgs = { 
    #       inherit inputs;
    #     }; # Pass flake inputs to our config
    #     modules = [ 
    #       nixos-hardware.nixosModules.lenovo-thinkpad-x1-yoga
    #       home-manager.nixosModules.home-manager
    #       ./common.nix
    #       ./devices/lenovoLaptop.nix
    #       ./devices/hardware-configurations/lenovoLaptop.nix
    #     ];

    # };
#   };
}
