{ configVars, ... }: {
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Host-specific Optional Configs ####################
    # ./common/optional/sops.nix
    # ./common/optional/hyprland.nix
    ./common/optional/mako.nix
    ./common/optional/stylix
  ];

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };
}
