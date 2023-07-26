# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
let
  baseconfig = { allowUnfree = true; };
  #unstable = import <nixpkgs-unstable> { config = baseconfig; };
in {
 inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    ./git.nix
    ./alacritty.nix
    ./packages.nix
    ./zsh.nix
    ./nvim.nix
    ./vscode.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [

   
      

    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };
  
  

  programs.home-manager.enable = true;
  home = {
    username = "sithis";
    homeDirectory = "/home/sithis";
    sessionVariables.EDITOR = "nvim";
  };







  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
