{ configVars, inputs, ... }: {
  imports = [
    #################### Required Configs ####################
    common/core # required
    
    #################### Host-specific Optional Configs ####################
    ./common/optional/sops.nix
    # ./common/optional/hyprland.nix
    #./common/optional/mako.nix
  ];

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };
}
