{ config, pkgs, ... }:
{
  users.users.root = {
    isSystemUser = true;
    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPQ1lOJawuuRoM4C3OWa/Bu+Mz9tzafFtoCg04c6B4fi sithpow@gmail.com"
    ];
  };
}
