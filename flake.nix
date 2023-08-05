{

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    nix-colors.url = "github:misterio77/nix-colors";

  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'

    # overlays = {
    #   pkg-sets = (
    #     final: prev: {
    #       unstable = import inputs.nixpkgs-unstabe { ststem = "x86_64-linux"; };
    #     }
    #   );
    # }


    nixosConfigurations.thor = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
        }; # Pass flake inputs to our config
        modules = [ 
          ./common.nix
          ./devices/lenovoLaptop.nix
          ./devices/hardware-configurations/lenovoLaptop.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-yoga
          home-manager.nixosModules.home-manager
        ];

    };
  };
}
