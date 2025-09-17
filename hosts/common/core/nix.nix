{ inputs, lib, ... }:
{
  nix = {
    buildMachines = [
      {
        hostName = "njord";
        system = "x86_64-linux";
        maxJobs = 6;
        speedFactor = 2;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
        mandatoryFeatures = [ ];
      }
    ];
    distributedBuilds = true;

    settings = {
      trusted-users = [
        "root"
        "@wheel"
        "sithis"
      ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://cosmic.cachix.org/"
        "https://cache.sammiller.dev"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "cache.sammiller.dev:QHSKg8Z59ZW6FC+9Qea4Ub3kIVyDuOubO4YMPCJF7XI="
      ];

      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
      flake-registry = ""; # Disable global flake registry   This is a hold-over setting from Misterio77. Not sure significance but likely to do with nix.registry entry below.
    };

    # Add each flake input as a registry to make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];

  };
}
