{ config, pkgs, ... }:
{
    users.users.sithis = {
        isNormalUser =  true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPQ1lOJawuuRoM4C3OWa/Bu+Mz9tzafFtoCg04c6B4fi sithpow@gmail.com" ];
        
    };
    programs.zsh.enable = true;
    home-manager.users.sithis = import ./home-manager.nix;
}