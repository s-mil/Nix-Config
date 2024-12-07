{ pkgs, inputs, config, lib, configVars, configLib, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  # sopsHashedPasswordFile = lib.optionalString (lib.hasAttr "sops" inputs)
  #   config.sops.secrets.sithis_passwd.path;
  pubKeys =
    lib.filesystem.listFilesRecursive (configLib.relativeToRoot "keys/");
in {
  # Decrypt sithis_passwd to /run/secrets-for-users/ so it can be used to create the user
  # sops.secrets.sithis_passwd.neededForUsers = true;
  # Required for password to be set via sops during system activation!
  # users.mutableUsers = false; 

  users.users.sithis = {
    isNormalUser = true;
    # hashedPasswordFile = sopsHashedPasswordFile;
    shell = pkgs.zsh; # default shell
    extraGroups = [ "wheel" "audio" "video" "libvirtd" ]
      ++ ifTheyExist [ "docker" "git" "mysql" "network" "flatpak" "adbusers" ];

    openssh.authorizedKeys.keys =
      lib.lists.forEach pubKeys (key: builtins.readFile key);

    packages = [ pkgs.home-manager ];
  };

  # Import this user's personal/home configurations

  home-manager.users.${configVars.username} = import (configLib.relativeToRoot
    "home/${configVars.username}/${config.networking.hostName}.nix");
}
