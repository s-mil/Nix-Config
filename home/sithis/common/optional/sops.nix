# home level sops. see hosts/common/optional/sops.nix for hosts level

{ inputs, config, ... }:
let
  secretsDirectory = builtins.toString inputs.nix-secrets;
  secretsFile = "${secretsDirectory}/secrets.yaml";
  homeDirectory = config.home.homeDirectory;
in {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    # This is the sithis/dev key and needs to have been copied to this location on the host
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${secretsFile}";
    validateSopsFiles = false;

    secrets = {
      "sithis_key" = { path = "${homeDirectory}/.ssh/id_ed25519"; };
    };
  };
}
