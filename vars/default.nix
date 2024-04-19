{ inputs, lib }:
{
  username = "sithis";
  domain = inputs.nix-secrets.domain;
  userFullName = inputs.nix-secrets.full-name;
  handle = "sithis";
  userEmail = inputs.nix-secrets.user-email;
  gitEmail = "23262411+s-mil@users.noreply.github.com";
  workEmail = inputs.nix-secrets.work-email;
  # networking = import ./networking.nix { inherit lib; };
}
