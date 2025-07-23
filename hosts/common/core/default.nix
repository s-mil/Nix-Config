{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./locale.nix # localization settings
      ./nix.nix # nix settings and garbage collection
      ./zsh.nix # load a basic shell just in case we need it without home-manager
      ./standardPkgs.nix # base packages on a system
      ./services/tailscale.nix # tailscale for interdevice networking
      ./services/rustic.nix # Rustic for backups
      ./services/syncthing.nix # syncthing for file syncing
      ./fonts.nix # fonts
      ./nh.nix
      ./monitoring.nix
      #./services/auto-upgrade.nix # auto-upgrade service
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nixpkgs = {
    # you can add global overlays here
    overlays = builtins.attrValues outputs.overlays;
    config = {allowUnfree = true;};
  };

  networking.timeServers = [
    "time.cloudflare.com"
  ];

  services.udisks2 = {enable = true;};
  hardware.enableRedistributableFirmware = true;
  security.sudo.enable = true;
  # Allow members of the "wheel" group to sudo:
  security.sudo.configFile = ''
    %wheel ALL=(ALL) ALL
  '';
}
