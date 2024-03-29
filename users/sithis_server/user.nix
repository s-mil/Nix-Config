{ config, pkgs,... }:
{
    users.users.sithis = {
        isNormalUser =  true;
        shell = pkgs.nushell;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPQ1lOJawuuRoM4C3OWa/Bu+Mz9tzafFtoCg04c6B4fi sithpow@gmail.com" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILVrEbYe/PAtsQ4q5+zr/Dy1Zu3NK92apcBcn2Igze4N sam@neumann-miller.com" ];
        
    };

    programs.zsh.enable = true;
    home-manager.users.sithis = import ./home-manager.nix;
}
