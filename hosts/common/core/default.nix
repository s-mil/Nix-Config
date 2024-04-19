{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix # localization settings
    ./nix.nix # nix settings and garbage collection
    ./sops.nix # secrets management
    ./zsh.nix # load a basic shell just in case we need it without home-manager
    ./standardPkgs.nix # base packages on a system
    ./services/tailscale.nix # tailscale for interdevice networking
    ./fonts.nix # fonts
   # ./nh.nix not ready yet
    #./services/auto-upgrade.nix # auto-upgrade service
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    # you can add global overlays here
    overlays = builtins.attrValues outputs.overlays;
    config = { allowUnfree = true; };
  };

  hardware.enableRedistributableFirmware = true;
}
