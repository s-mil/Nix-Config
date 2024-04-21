{ pkgs, inputs, config, lib, configVars, configLib, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  sopsHashedPasswordFile = lib.optionalString (lib.hasAttr "sops" inputs)
    config.sops.secrets.sithis_passwd.path;
  pubKeys =
    lib.filesystem.listFilesRecursive (configLib.relativeToRoot "keys/");
in {
  # Decrypt sithis_passwd to /run/secrets-for-users/ so it can be used to create the user
  sops.secrets.sithis_passwd.neededForUsers = true;
  users.mutableUsers =
    false; # Required for password to be set via sops during system activation!

  users.users.sithis = {
    isNormalUser = true;
    hashedPasswordFile = sopsHashedPasswordFile;
    shell = pkgs.zsh; # default shell
    extraGroups = [ "wheel" "audio" "video" ]
      ++ ifTheyExist [ "docker" "git" "mysql" "network" ];

    openssh.authorizedKeys.keys =
      lib.lists.forEach pubKeys (key: builtins.readFile key);

    packages = [ pkgs.home-manager ];
  };

  # FIXME This should probably be host specific. Also need to confirm that this is the correct place to do this.
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120 # only ask for password every 120 minutes
  '';

  # Import this user's personal/home configurations

  home-manager.users.${configVars.username} = import (configLib.relativeToRoot
    "home/${configVars.username}/${config.networking.hostName}.nix");
}
