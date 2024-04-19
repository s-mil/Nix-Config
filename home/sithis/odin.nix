{ configVars, ... }: {
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Host-specific Optional Configs ####################
    ./optional/sops.nix
  ];

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };
}
